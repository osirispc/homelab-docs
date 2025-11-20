# 🏔️ The Lodge Homelab Docs

#Live Update from 

Welcome to your homelab documentation.  
Use this page as your starting point for everything in the Lodge.

 <div class="fbi-classified">CLASSIFIED</div>

---

## 🔧 Infrastructure

- [Infrastructure Overview](infra/overview.md)
- [Network Diagram](infra/network-diagram.md)
- [Storage & Backups](infra/storage-backups.md)
- [Automation & Workflows](infra/automation.md)

---

## 🖥️ Servers

- [Pacard Sawmill](servers/pacard-sawmill.md)
- [Gordon Cole](servers/gordon-cole.md)
- [Bookhouse](servers/bookhouse.md)
- [Blockbuster](servers/blockbuster.md)
- [RARR Media Server](servers/rarr.md)
- [DNS Gateway (VM 198)](servers/dns-gateway.md)
- [The White Lodge (PVE Node)](servers/thewhitelodge.md)
- [The Black Lodge (PVE Node)](servers/theblacklodge.md)
- [The Red Room (PBS)](servers/theredroom.md)

---

## 📦 Applications

### Media

- [Jellyfin](apps/jellyfin.md)
- [Radarr](apps/radarr.md)
- [Sonarr](apps/sonarr.md)
- [Prowlarr](apps/prowlarr.md)
- [qBittorrent (VPN)](apps/qbittorrent.md)
- [Xteve / TVHeadend](apps/xteve-tvheadend.md)

### Books & Audio

- [Readarr](apps/readarr.md)
- [Kavita](apps/kavita.md)
- [Audiobookshelf](apps/audiobookshelf.md)

### Networking & DNS

- [Pi-hole](apps/pihole.md)
- [Unbound](apps/unbound.md)
- [WireGuard (wg-easy)](apps/wireguard.md)

### Infrastructure Apps

- [Portainer](apps/portainer.md)
- [Nginx Proxy Manager](apps/npm.md)
- [Homepage Dashboard](apps/homepage.md)
- [Flame Dashboard](apps/flame.md)

---

## 🧭 Quick HTML “cards” (optional)

If you want a slightly fancier layout, you can add this at the *bottom*:

```html
<hr>

<h2>Quick Jump</h2>

<table>
  <tr>
    <td><a href="infra/overview/">Infrastructure Overview</a></td>
    <td>High-level view of nodes, VMs, and networks.</td>
  </tr>
  <tr>
    <td><a href="servers/pacard-sawmill/">Pacard Sawmill</a></td>
    <td>Portainer management VM for all Docker hosts.</td>
  </tr>
  <tr>
    <td><a href="servers/rarr/">RARR Media Server</a></td>
    <td>Jellyfin + Radarr/Sonarr + download stack.</td>
  </tr>
  <tr>
    <td><a href="cloudflare/cloudflare-tunnel-code-server/">Cloudflare Tunnel for Code-Server</a></td>
    <td>How you reach code-server securely from anywhere.</td>
  </tr>
</table>


Last updated: Sun Nov 16 05:21:03 PM UTC 2025
