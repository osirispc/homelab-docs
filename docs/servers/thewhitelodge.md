# thewhitelodge

**Role:** Primary media server (RARR stack master)  
**OS:** Debian 12 (bookworm)  
**Primary IP:** 192.168.199.193  
**Status:** Active

---

## Overview
The White Lodge hosts the main RARR stack: Radarr, Sonarr, Jellyfin, qBittorrent, and Gluetun.  
It serves as the production media hub for the network and the primary sync source for The Black Lodge.

---

## Key Services
- Jellyfin (Movies, Shows, Trailers)
- Radarr, Sonarr, Prowlarr, Jellyseerr
- qBittorrent with VPN via Gluetun
- ZFS dataset for `/mnt/data/movies` and `/mnt/data/shows`

---

## Maintenance Notes
- ZFS snapshots replicate to The Black Lodge  
- Synced nightly using `lodge-mirror.sh`  
- Backed up via Proxmox Backup Server  
- Config stored in `/mnt/data/configs/`

---

## Failover Plan
In the event of downtime, The Black Lodge takes over via manual ZFS replication and Jellyfin restore.  
Rsync ensures latest metadata and libraries are mirrored.

---

## Recent Changes
_Last update: {{ date }}_
