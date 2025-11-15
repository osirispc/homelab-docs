<div class="fbi-evidence">EVIDENCE</div>


nav:
  - Home: index.md

  - Infrastructure:
      - Overview: infra/overview.md
      - Network Diagram: infra/network-diagram.md
      - Storage & Backups: infra/storage-backups.md
      - Automation & Workflows: infra/automation.md

  - Servers:
      - Pacard Sawmill: servers/pacard-sawmill.md
      - Gordon Cole: servers/gordon-cole.md
      - Bookhouse: servers/bookhouse.md
      - Blockbuster: servers/blockbuster.md
      - RARR (Media Server): servers/rarr.md
      - DNS Gateway (VM 198): servers/dns-gateway.md
      - The White Lodge (PVE Node): servers/thewhitelodge.md
      - The Black Lodge (PVE Node): servers/theblacklodge.md
      - The Red Room (PVE Node / PBS): servers/theredroom.md

  - Applications:
      - Media:
          - Jellyfin: apps/jellyfin.md
          - Radarr: apps/radarr.md
          - Sonarr: apps/sonarr.md
          - Prowlarr: apps/prowlarr.md
          - qBittorrent (VPN): apps/qbittorrent.md
          - Xteve / TVHeadend: apps/xteve-tvheadend.md
      - Books:
          - Readarr: apps/readarr.md
          - Kavita: apps/kavita.md
          - Audiobookshelf: apps/audiobookshelf.md
      - Networking & DNS:
          - Pi-hole: apps/pihole.md
          - Unbound: apps/unbound.md
          - WireGuard: apps/wireguard.md
      - Infrastructure Apps:
          - Portainer: apps/portainer.md
          - Nginx Proxy Manager: apps/npm.md
          - Homepage Dashboard: apps/homepage.md
          - Flame Dashboard: apps/flame.md

  - Cloudflare:
      - Tunnel for Code-Server: cloudflare/cloudflare-tunnel-code-server.md
      - Future Tunnels: cloudflare/tunnels.md

  - Guides:
      - Container Deployment SOP: guides/container-deploy.md
      - VM Creation SOP: guides/vm-create.md
      - Network Troubleshooting: guides/network-troubleshoot.md
      - Backup & Restore SOP: guides/backup-restore.md


**Important:**  
Mermaid diagrams only work inside triple backticks \`\`\`mermaid

---

# ✅ **3. Make sure it’s in the navigation (mkdocs.yml)**

You already have:

```yaml
  - Infrastructure:
      - Overview: infra/overview.md
      - Network Diagram: infra/network-diagram.md

