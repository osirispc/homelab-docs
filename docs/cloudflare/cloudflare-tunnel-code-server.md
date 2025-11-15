# **Secure Cloudflare Tunnel Access to Code-Server (pacard-sawmill)**

This document outlines the full configuration used to expose `code-server` on **pacard-sawmill** securely over the internet using **Cloudflare Tunnel** and **Cloudflare Zero Trust**.
This ensures maximum security, no LAN exposure, and MFA-protected access from anywhere.

---

## **Overview**

This setup provides:

* Secure remote access to code-server
* Zero Trust identity protection (email + MFA)
* No VPN required
* No ports opened on your home network
* code-server bound only to localhost for safety
* Cloudflare Tunnel handles all public traffic

Traffic flow:

```
You → Cloudflare Zero Trust → Cloudflare Tunnel → pacard-sawmill → code-server
```

LAN access is intentionally disabled.

---

## **1. Install cloudflared on pacard-sawmill**

```bash
curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o cloudflared.deb
sudo dpkg -i cloudflared.deb
```

Authenticate the instance:

```bash
cloudflared tunnel login
```

Choose the domain **osirispc.com**.

---

## **2. Create the Tunnel**

```bash
cloudflared tunnel create pacard
```

This creates credentials:

```
/home/osirisortiz/.cloudflared/<UUID>.json
```

---

## **3. Configure the Tunnel**

Create and edit the config:

```bash
sudo mkdir -p /etc/cloudflared
sudo nano /etc/cloudflared/config.yml
```

Paste:

```yaml
tunnel: pacard
credentials-file: /home/osirisortiz/.cloudflared/<UUID>.json

ingress:
  - hostname: code.osirispc.com
    service: http://127.0.0.1:8080
  - service: http_status:404
```

Replace `<UUID>` accordingly.

---

## **4. Create DNS Route**

```bash
cloudflared tunnel route dns pacard code.osirispc.com
```

This creates the necessary CNAME record.

---

## **5. Install and Start the Tunnel Service**

```bash
sudo cloudflared service install
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
```

Verify:

```bash
systemctl status cloudflared
```

Should show: **Active (running)**.

---

## **6. Secure with Cloudflare Zero Trust**

Navigate to:

```
Cloudflare Dashboard → Zero Trust → Access → Applications → Add Application
```

Select **Self-hosted**.

Configure:

* **Domain:** `code.osirispc.com`
* **Name:** Code Server

Access policy:

```
Action: Allow
Selector: Emails
Value: osirisortizpc@gmail.com
```

This requires identity login + MFA before accessing code-server.

---

## **7. Configure code-server to Bind Locally Only**

File:

```
~/.config/code-server/config.yaml
```

Recommended:

```yaml
auth: none
bind-addr: 127.0.0.1:8080
cert: false
```

Restart code-server:

```bash
pkill -f code-server
code-server
```

---

## **8. Final Behavior Summary**

### **External access (WORKS):**

```
https://code.osirispc.com
```

### **Local machine access (WORKS):**

```
http://127.0.0.1:8080
```

### **LAN access (BLOCKED intentionally):**

```
http://192.168.199.177:8080
```

This is the expected Zero Trust behavior.

---

## **Optional: Enable LAN Access Later**

Change:

```yaml
bind-addr: 0.0.0.0:8080
```

Restart code-server.

LAN devices will now reach the service.

---

## **Result**

You now have:

* A secure, MFA-protected Cloudflare Tunnel
* A globally accessible development environment
* Zero exposure on your LAN
* A professional Zero Trust setup
* Fully isolated code-server endpoint

This configuration is ideal for a hardened, flexible, secure homelab.

---
