# theblacklodge

**Role:** Secondary Proxmox NodeBackup / mirror media server  
**OS:** Debian 12 (bookworm)  
**Primary IP:** 192.168.199.101
**Status:** Active (standby replication node)

---

## Overview
The Black Lodge acts as the failover counterpart to The White Lodge.  
It mirrors media libraries, configurations, and snapshots via ZFS and rsync.  
When The White Lodge goes dark, The Black Lodge assumes its identity temporarily.

---

## Key Services
- Jellyfin (standby configuration)
- RARR stack (backup, disabled by default)
- Rsync mirror target for `/mnt/data/movies` and `/mnt/data/shows`
- Portainer Agent for container control

---

## Maintenance Notes
- Receives media and config sync via `lodge-mirror.sh`
- Keeps ZFS snapshots aligned daily
- Does **not** delete missing files (append-only sync)
- PBS handles local and offsite backups

---

## Failover Plan
During failover, The Black Lodge mounts the mirrored datasets and starts the Jellyfin container.  
Cloudflare DNS may be updated manually or via Keepalived floating IP for continuity.

---

## Recent Changes
_Last update: {{ date }}_
