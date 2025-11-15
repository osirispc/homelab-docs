er# 🏔️ Homelab Servers Overview

This page documents each major server and VM running inside the Lodge architecture.  
Each entry includes its purpose, IP, Docker containers, and key functions.

---

## 🌲 theblacklodge (PVE Node)
Primary compute node of the Homelab.  
Houses several critical VMs:

### **pacard-sawmill (VM 901)**
*Role:* Standalone Portainer management VM  
*IP:* 192.168.199.177  
*Containers:*
- portainer
- portainer_agent

---

### **blockbuster (VM)**
*Role:* DNS + archival tools  
*Containers:*
- unbound  
- portainer_agent  
- blockbuster (custom archive app)

---

### **rarr (VM 193)**
*Role:* Full media automation stack  
*Containers include:*  
- Sonarr  
- Radarr  
- Readarr (books VM separate)  
- Prowlarr  
- qBittorrent (VPN)  
- Jellyfin (primary)  
- Tablo, xteve, tvheadend, etc.

---

## 🔥 gordon-cole (VM)
Reverse-proxy and portals VM.

*Containers:*
- **npm-db** (MariaDB for NPM)
- **npm-app** (Nginx Proxy Manager)
- **homepage** (dashboard)
- **flame** (alternate dashboard)
- **portainer_agent**

Handles external access, internal dashboards, and Cloudflare integrations.

---

## 📚 bookhouse (VM)
Books, audiobooks, and remote-access hub.

*Containers:*
- **wg-easy** (WireGuard server)
- **kavita** (manga / book server)
- **audiobookshelf**
- **readarr**
- **portainer**
- **portainer_agent**

---

## 🎥 dns-gateway (VM 198)
Your dedicated network filtering stack.

*Containers:*
- **pi-hole**
- **unbound**
- **portainer_agent**

---

## 🧊 thewhitelodge (PVE Node)
Secondary node, often running:
- docker-portainer (VM 150)
- blockbuster (VM 152)
- rarr-backup mirror
- dns-vm-2 (VM 198 mirror)
- VM used for testing, mirroring, and failover

---

## 🔴 theredroom (PVE Node / PBS)
Backup + storage node (Proxmox Backup Server).
- Runs PBS
- Hosts mirrored datasets
- Stores snapshots + ZFS replication

---

# 🧭 Summary Diagram (Mermaid)

```mermaid
flowchart TD

subgraph PVE1[theblacklodge]
    A1[VM: pacard-sawmill<br/>portainer+agent]
    A2[VM: rarr<br/>full media stack]
    A3[VM: blockbuster<br/>unbound + archive app]
end

subgraph PVE2[thewhitelodge]
    B1[VM: docker-portainer]
    B2[VM: blockbuster mirror]
    B3[VM: dns-vm-2]
end

subgraph PBS[theredroom]
    C1[Proxmox Backup Server]
end

subgraph GC[gordon-cole]
    D1[npm-db]
    D2[npm-app (NPM)]
    D3[homepage]
    D4[flame]
    D5[portainer_agent]
end

subgraph BK[bookhouse]
    E1[wg-easy]
    E2[readarr]
    E3[kavita]
    E4[audiobookshelf]
    E5[portainer]
end

subgraph DNS[dns-gateway]
    F1[pi-hole]
    F2[unbound]
    F3[portainer_agent]
end
