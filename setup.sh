#!/bin/bash

echo "===== START SETUP ====="

# LOGGING
exec > /root/setup.log 2>&1

# -----------------------------
# DOMAIN SETUP (CHANGE THIS ONLY)
# -----------------------------
DOMAIN="Add your domain"

# -----------------------------
# BACKUP URL (CHANGE THIS ONLY, cloud panel backup link )
# -----------------------------
BACKUP_URL="https://example.com/site-backup.wpress"

# -----------------------------
# SSH KEY SETUP
# -----------------------------
PUBLIC_KEY="Add your key"
USER="root"
SSH_DIR="/root/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if ! grep -qF "$PUBLIC_KEY" "$AUTHORIZED_KEYS" 2>/dev/null; then
  echo "$PUBLIC_KEY" >> "$AUTHORIZED_KEYS"
fi

chmod 600 "$AUTHORIZED_KEYS"
chown "$USER":"$USER" "$AUTHORIZED_KEYS"

# -----------------------------
# INSTALL DOCKER
# -----------------------------
echo "===== INSTALL DOCKER ====="

curl -O https://kingtam.win/usr/uploads/script/install-docker.sh
chmod +x install-docker.sh
./install-docker.sh

until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker..."
  sleep 3
done

# -----------------------------
# INSTALL NGINX + GIT + WGET
# -----------------------------
apt update -y
apt install nginx git wget -y

systemctl enable nginx
systemctl start nginx

# -----------------------------
# NGINX CONFIG
# -----------------------------
echo "===== CONFIGURE NGINX ====="

rm -f /etc/nginx/sites-enabled/default

cat <<EOF > /etc/nginx/sites-enabled/web.conf
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_http_version 1.1;

        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

nginx -t
systemctl restart nginx

# -----------------------------
# CLONE PROJECT
# -----------------------------
cd /home
git clone https://github.com/hansikashama01/production-wordpress
cd production-wordpress

docker network create wordpress-network || true

cat <<EOF > .env
MARIADB_VERSION=10
PHP_VERSION=8.2

MYSQL_DATABASE=hazh_db
MYSQL_USER=hazh_user
MYSQL_PASSWORD=hazh@123+
MYSQL_ROOT_PASSWORD=roothazh@123+

WORDPRESS_TABLE_PREFIX=wp_
EOF

docker compose up -d

# -----------------------------
# FIX PHP CONFIG
# -----------------------------
mkdir -p php
cat <<EOF > php/custom.ini
disable_functions =
EOF

docker compose restart wp_app

# -----------------------------
# WAIT WORDPRESS
# -----------------------------
echo "Waiting for WordPress..."
sleep 20

# -----------------------------
# INSTALL WP-CLI
# -----------------------------
docker exec wp_app curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
docker exec wp_app chmod +x wp-cli.phar
docker exec wp_app mv wp-cli.phar /usr/local/bin/wp

# -----------------------------
# WORDPRESS AUTO INSTALL
# -----------------------------
docker exec wp_app wp core install \
  --url="http://$DOMAIN" \
  --title="Hi , your title" \
  --admin_user="admin" \
  --admin_password="add your password" \
  --admin_email="Add your mail" \
  --skip-email \
  --allow-root

# -----------------------------
# DOWNLOAD PLUGINS FROM GITHUB
# -----------------------------
echo "===== DOWNLOAD PLUGINS ====="

cd /home

wget https://raw.githubusercontent.com/hansikashama01/my-plugins/main/all-in-one-wp-migration.zip
wget https://raw.githubusercontent.com/hansikashama01/my-plugins/main/all-in-one-wp-migration-unlimited-extension.zip

# -----------------------------
# INSTALL PLUGINS
# -----------------------------
echo "===== INSTALL PLUGINS ====="

docker cp /home/all-in-one-wp-migration.zip wp_app:/tmp/
docker cp /home/all-in-one-wp-migration-unlimited-extension.zip wp_app:/tmp/

docker exec wp_app wp plugin install /tmp/all-in-one-wp-migration.zip --activate --allow-root
docker exec wp_app wp plugin install /tmp/all-in-one-wp-migration-unlimited-extension.zip --activate --allow-root

# -----------------------------
# DOWNLOAD BACKUP
# -----------------------------
echo "===== DOWNLOAD BACKUP ====="

mkdir -p /opt/www/wordpress/wp-content/ai1wm-backups

wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64)" \
--max-redirect=20 \
--timeout=60 \
-O /opt/www/wordpress/wp-content/ai1wm-backups/site.wpress \
"$BACKUP_URL"

# -----------------------------
# FIX PERMISSIONS
# -----------------------------
echo "===== FIX PERMISSIONS ====="

docker exec wp_app chown -R www-data:www-data /var/www/html/wp-content
docker exec wp_app chmod -R 755 /var/www/html/wp-content

# -----------------------------
# COPY TO PLUGIN STORAGE
# -----------------------------
echo "===== COPY TO PLUGIN STORAGE ====="

docker exec wp_app mkdir -p /var/www/html/wp-content/plugins/all-in-one-wp-migration/storage
docker exec wp_app cp /var/www/html/wp-content/ai1wm-backups/site.wpress /var/www/html/wp-content/plugins/all-in-one-wp-migration/storage/

# -----------------------------
# RESTORE BACKUP
# -----------------------------
echo "===== RESTORE BACKUP ====="

sleep 30

docker exec wp_app wp ai1wm restore site.wpress --yes --allow-root

echo "===== FINISHED SUCCESSFULLY ====="
