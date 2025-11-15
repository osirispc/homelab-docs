# pacard-sawmill

**Role:** Development server / code-server host  
**OS:** Ubuntu 24.04 LTS 
**Primary IP:** 192.168.199.177  
**Status:** Active

---

## Overview
pacard-sawmill serves as the main development environment for internal and external projects.  
It runs code-server, Docker, and several MkDocs documentation sites.

---

## Key Services
- code-server (`code.osirispc.com` via Cloudflare Tunnel)
- Portainer Agent (port 9001)
- Homelab Docs (`homelab-docs` auto-commit + watcher)
- Docker-based development containers

---

## Maintenance Notes
- Automatic updates via `unattended-upgrades`
- Auto-commit logs rotate every 50 lines
- Watched in real-time by `homelab-autocommit.service`
- Backups planned for sync to `theowlcave` NAS

---

## Recent Changes
_Last update: {{ date }}_
