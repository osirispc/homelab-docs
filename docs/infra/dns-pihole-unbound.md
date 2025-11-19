# 📘 **Pi-hole + Unbound Deployment (Host Networking Mode)**

*A Lodge Infrastructure Case File*

## 📝 Overview

This document describes the complete setup of **Pi-hole** with **Unbound** running on an Ubuntu 24.04 virtual machine using Docker.
This configuration gives you:

* **Network-wide ad blocking**
* **Full recursive DNS (no 3rd-party DNS)**
* **Local hostname resolution**
* **High privacy**
* **Fast DNS caching**
* **Simple failover options**

Pi-hole operates in **host networking mode** for maximum reliability, while Unbound runs in a standard Docker bridge network (exposing port 5335).

---

## 🏛️ Architecture

```
┌────────────────────────────────────────────────────────┐
│                 Lodge Network (LAN)                    │
│    Devices → 192.168.199.53 (Pi-hole DNS Server)       │
└────────────────────────────────────────────────────────┘
                │
                ▼
┌────────────────────────────────────────────────────────┐
│          Pi-hole (Docker, host networking)             │
│  - Listens directly on host ports: 53, 80, 443, 123    │
│  - Forwards DNS to Unbound at 127.0.0.1#5335           │
└────────────────────────────────────────────────────────┘
                │
                ▼
┌────────────────────────────────────────────────────────┐
│              Unbound (Docker bridge)                   │
│        Listens on 0.0.0.0:5335 (TCP+UDP)               │
│   Recursively queries the DNS root servers             │
└────────────────────────────────────────────────────────┘
```

---

## 🖥️ VM Requirements

* Ubuntu Server **24.04 LTS**
* Static IP:
  **192.168.199.53**
* 1 CPU / 1–2GB RAM minimum
* Docker installed
* UFW disabled or configured to allow DNS (port 53)

---

## 🧰 Install Docker & Docker Compose

```bash
sudo apt update
sudo apt install docker.io docker-compose -y
sudo systemctl enable --now docker
```

---

## 📦 Directory Structure

Create the directory:

```bash
mkdir -p /opt/pihole
cd /opt/pihole
```

---

## 🧾 Docker Compose File

Create:

```bash
sudo nano /opt/pihole/docker-compose.yml
```

Paste:

```yaml
version: "3.3"

services:
  pihole:
    container_name: pihole
    image: pihole/pihole:latest
    network_mode: host
    environment:
      TZ: "America/New_York"
      WEBPASSWORD: "admin"
      DNSMASQ_LISTENING: all
    volumes:
      - ./etc-pihole:/etc/pihole
      - ./etc-dnsmasq.d:/etc/dnsmasq.d
    restart: unless-stopped

  unbound:
    container_name: unbound
    image: mvance/unbound:latest
    ports:
      - "5335:53/tcp"
      - "5335:53/udp"
    restart: unless-stopped
```

---

## ▶️ Deployment

Run:

```bash
cd /opt/pihole
sudo docker-compose down
sudo docker-compose up -d --force-recreate
```

Verify the containers:

```bash
docker ps
```

You should see:

* Pi-hole running and healthy
* Unbound running on port 5335

---

## 🧪 Testing DNS

Test recursion and forwarding:

```bash
dig @192.168.199.53 google.com
dig @192.168.199.53 cloudflare.com
dig @192.168.199.53 nasa.gov
```

Expected output:

* `status: NOERROR`
* `ANSWER SECTION`
* Times varying from **1ms (cached)** to **100+ms (recursive)**

---

## ⚙️ Pi-hole Configuration

Go to:

```
http://192.168.199.53/admin
```

### Upstream DNS

Disable all upstream DNS providers.

Add only:

```
127.0.0.1#5335
```

### Advanced DNS settings

Enable:

* ✔ Listen on all interfaces
* ✔ Never forward non-FQDNs
* ✔ Never forward reverse lookups for private ranges

---

## 🏠 Optional: Conditional Forwarding

To resolve local device names:

**Settings → DNS → Conditional Forwarding**

* **Local network:** `192.168.199.0/24`
* **Router IP:** `192.168.199.1`
* **Local domain name:** `lan`

---

## 📡 Router Configuration

Point LAN DNS to:

```
192.168.199.53
```

All clients will now use Pi-hole → Unbound → Root DNS servers.

---

## 🧰 Troubleshooting

### ❌ `connection refused`

Cause: Pi-hole not running in host networking OR port 53 in use.

Fix:

* Ensure `network_mode: host` is present
* Restart Pi-hole

---

### ❌ `docker-proxy` appears in ss output

Cause: Pi-hole using `ports:` mapping instead of host networking.

Fix:

* Remove ALL `ports:` from Pi-hole config
* Redeploy containers

---

### ❌ Unbound not responding

Check port:

```bash
dig @127.0.0.1 -p 5335 google.com
```

If no response:

* Unbound container not ready
* Port blocked
* Container crashed

---

### ❌ Pi-hole not resolving LAN hostnames

Enable Conditional Forwarding
OR add host records in:

```
/etc/pihole/custom.list
```

---

## 🧭 Summary

You now have:

* Full DNS privacy
* No 3rd-party upstream DNS
* Root-level recursion
* Fast caching
* Pi-hole running natively at host network speed

A clean, secure, resilient Lodge DNS system.

---

If you'd like an **advanced version** of this doc with:

🔧 Hardening (DNSSEC, QNAME minimization, root anchors)
📊 Grafana dashboards
🔥 High availability (2nd Pi-hole)
📦 GitHub-ready SOP version
🔺 Twin Peaks–themed version

Just say the word.
