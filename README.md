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

#  Features

 Fully Automated WordPress Deployment  
 AWS Lightsail Launch Script Support  
 Dockerized WordPress Environment  
 Nginx Reverse Proxy Configuration  
 Automatic Plugin Installation  
 Automatic Backup Restore  
 WP-CLI Automation  
 Infrastructure Provisioning Automation  
 One-Click Migration Workflow  

---

#  How It Works

```text
Old WordPress Server
        ↓
 .wpress Backup
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

#  Requirements

Before using this project you need:

- AWS Lightsail or Ubuntu VPS
- Domain name
- Public `.wpress` backup URL
- DNS access (Cloudflare / Namecheap / Route53)

---

#  Quick Start

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

Edit this:
## DOMAIN SETUP (CHANGE THIS ONLY) 
```bash
DOMAIN="yourdomain.com"
```

## BACKUP URL (CHANGE THIS ONLY)
```bash
BACKUP_URL="https://example.com/site-backup.wpress"
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

## 5. Wait 3-5 Minutes

The system will automatically:

- Install Docker
- Install Nginx
- Deploy WordPress
- Install Plugins
- Download Backup
- Restore Website

---

#  Finished

Open:

```text
http://yourdomain.com
```

Your restored website should now be live.

---

#  Repository Structure

```text
wordpress-auto-restore/
│
├── setup.sh
├── README.md
├── LICENSE

```

---

#  setup.sh Overview

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

#  DNS Setup Example

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

#  Security Notes

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

#  SSL Setup (Optional)

Install Certbot:

```bash
apt install certbot python3-certbot-nginx -y
```

Run:

```bash
certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

---

#  Why This Project?

This project was built to simplify:

- WordPress migrations
- Disaster recovery workflows
- Infrastructure automation
- Server provisioning

using DevOps principles and automation scripting.

---

#  Technologies Used

- Bash
- Docker
- Nginx
- WordPress
- WP-CLI
- Linux
- AWS Lightsail

---

#  Future Improvements

Planned upgrades:

- Automatic SSL setup
- Cloudflare API integration
- Multi-site support
- Backup scheduler

---



# Author

Hansika Shamal

GitHub:

https://github.com/hansikashama01
