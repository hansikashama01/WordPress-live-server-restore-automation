# WordPress Auto Restore

> One-click WordPress migration & auto restore system for AWS Lightsail and Ubuntu VPS servers.

Automatically installs and configures:

- Docker
- Nginx
- WordPress
- WP-CLI
- All In One WP Migration
- Automatic `.wpress` backup restore

---

# 🚀 Features

✅ Fully Automated WordPress Deployment  
✅ AWS Lightsail Launch Script Support  
✅ Dockerized WordPress Environment  
✅ Nginx Reverse Proxy Configuration  
✅ Automatic Plugin Installation  
✅ Automatic Backup Restore  
✅ WP-CLI Automation  
✅ Infrastructure Provisioning Automation  
✅ One-Click Migration Workflow  

---

# 🏗 How It Works

```text
Old WordPress Server
        ↓
Generate .wpress Backup
        ↓
Upload Backup Online
        ↓
Create AWS Lightsail Instance
        ↓
Add Launch Script
        ↓
Automatic Setup Starts
        ↓
Docker + WordPress + Restore
        ↓
Website Live
```

---

# 📋 Requirements

Before using this project you need:

- AWS Lightsail or Ubuntu VPS
- Domain name
- Public `.wpress` backup URL
- DNS access (Cloudflare / Namecheap / Route53)

---

# ⚡ Quick Start

## 1. Create AWS Lightsail Instance

Go to:

https://lightsail.aws.amazon.com/

Choose:

- Ubuntu 22.04

---

## 2. Add Launch Script

Inside:

```text
Advanced Details
→ Launch Script
```

Paste this:

```bash
#!/bin/bash

export DOMAIN="example.com"

export BACKUP_URL="https://example.com/site.wpress"

curl -O https://raw.githubusercontent.com/YOUR_USERNAME/wordpress-auto-restore/main/setup.sh

chmod +x setup.sh

./setup.sh
```

---

## 3. Create Instance

Wait until instance becomes active.

---

## 4. Point Domain To Server

Add DNS records.

### A Record

```text
Type: A
Name: @
Value: SERVER_IP
```

### WWW Record

```text
Type: CNAME
Name: www
Value: example.com
```

---

## 5. Wait 5-15 Minutes

The system will automatically:

- Install Docker
- Install Nginx
- Deploy WordPress
- Install Plugins
- Download Backup
- Restore Website

---

# 🎉 Finished

Open:

```text
http://yourdomain.com
```

Your restored website should now be live.

---

# 📂 Repository Structure

```text
wordpress-auto-restore/
│
├── setup.sh
├── README.md
├── LICENSE
├── .gitignore
├── screenshots/
└── docs/
```

---

# 🔧 setup.sh Overview

The script automatically performs:

## System Setup

- Updates Ubuntu packages
- Installs Docker
- Installs Nginx
- Installs Git/Wget/Curl

## WordPress Deployment

- Creates Docker containers
- Configures environment variables
- Starts WordPress stack

## Automation Tasks

- Downloads WP-CLI
- Installs WordPress
- Installs migration plugins
- Downloads backup
- Restores backup automatically

---

# 🌐 DNS Setup Example

Example using Cloudflare.

## Root Domain

```text
Type: A
Name: @
IP: YOUR_SERVER_IP
```

## WWW

```text
Type: CNAME
Name: www
Target: yourdomain.com
```

---

# 📸 Screenshots

## AWS Lightsail Launch Script

```text
screenshots/lightsail-launch-script.png
```

## Cloudflare DNS

```text
screenshots/cloudflare-dns.png
```

## Final Restored Website

```text
screenshots/final-site.png
```

---

# 🛠 Troubleshooting

## Check Installation Logs

```bash
cat /root/setup.log
```

---

## Check Docker Containers

```bash
docker ps
```

---

## Restart Containers

```bash
docker compose restart
```

---

## Restart Nginx

```bash
systemctl restart nginx
```

---

# 🔒 Security Notes

Never expose:

- Production passwords
- Private SSH keys
- Private backup URLs
- API tokens
- Database credentials

Recommended:

- Use temporary backup links
- Rotate passwords regularly
- Enable HTTPS
- Use Cloudflare protection

---

# 🔐 SSL Setup (Optional)

Install Certbot:

```bash
apt install certbot python3-certbot-nginx -y
```

Run:

```bash
certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

---

# 🧠 Why This Project?

This project was built to simplify:

- WordPress migrations
- Disaster recovery workflows
- Infrastructure automation
- Server provisioning

using DevOps principles and automation scripting.

---

# 🧰 Technologies Used

- Bash
- Docker
- Nginx
- WordPress
- WP-CLI
- Linux
- AWS Lightsail

---

# 📈 Future Improvements

Planned upgrades:

- Automatic SSL setup
- Cloudflare API integration
- Interactive installer
- Multi-site support
- Monitoring dashboard
- Terraform integration
- Kubernetes support
- Backup scheduler

---

# 🏷 Recommended GitHub Topics

```text
wordpress
docker
devops
automation
aws
lightsail
bash
linux
nginx
wp-cli
migration
```

---

# 📄 License

MIT License

Copyright (c) 2026 Hansika Shamal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files to deal in the Software
without restriction.

---

# ⭐ Support

If this project helped you:

- Star the repository
- Fork the project
- Share with others

---

# 👨‍💻 Author

Hansika Shamal

GitHub:

https://github.com/hansikashama01
