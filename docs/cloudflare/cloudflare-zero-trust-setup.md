# Cloudflare Zero Trust + Tunnel Setup Guide
_A complete step-by-step reference for securing homelab services behind Cloudflare._

---

## 🌐 Overview

This guide explains how to:

1. Move DNS to Cloudflare  
2. Set up Cloudflare Zero Trust  
3. Create a Cloudflare Tunnel  
4. Protect services with Access  
5. Configure public hostnames  
6. Test, verify, and troubleshoot  

All commands and YAML snippets are in fenced code blocks with MkDocs copy-buttons.

---

# 1️⃣ Move DNS to Cloudflare

## Step 1 — Add your domain
Cloudflare Dashboard → **Add a site**

Enter your domain:
```
osirispc.com
```

Select the free plan and continue.

---

## Step 2 — Change nameservers at your registrar
Cloudflare will assign two nameservers, for example:

```
bowen.ns.cloudflare.com
paige.ns.cloudflare.com
```

At GoDaddy (or your registrar):

1. Go to **DNS → Nameservers → Change**
2. Enter Cloudflare nameservers
3. Save

---

## Step 3 — Verify nameserver propagation

Visit:
```
https://dnschecker.org/#NS/osirispc.com
```

Resolvers should show **only** Cloudflare nameservers.

---

# 2️⃣ Enable Cloudflare Zero Trust

Cloudflare Dashboard → **Zero Trust**

Follow the initial setup prompts.

## Step 1 — Configure identity providers
Common choices:

- Google
- GitHub
- One-time PIN
- Azure AD

Enable whichever your organization uses.

---

## Step 2 — Set an organization login domain
Example:
```
osirispc.cloudflareaccess.com
```

---

# 3️⃣ Install & Create Cloudflare Tunnel

SSH into the server hosting your internal services.

## Step 1 — Install cloudflared

### Debian/Ubuntu:
```bash
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
  -o cloudflared.deb

sudo dpkg -i cloudflared.deb
```

---

## Step 2 — Authenticate cloudflared
```bash
cloudflared tunnel login
```

Follow the browser link and authenticate.

---

## Step 3 — Create a named tunnel
```bash
cloudflared tunnel create code-tunnel
```

A credentials file will be generated.

---

## Step 4 — Configure ingress rules

Create:
```
/etc/cloudflared/config.yml
```

Example:
```yaml
tunnel: code-tunnel
credentials-file: /etc/cloudflared/<your-tunnel-uuid>.json

ingress:
  - hostname: code.osirispc.com
    service: http://localhost:8002

  - hostname: docs.osirispc.com
    service: http://localhost:8282

  - service: http_status:404
```

---

## Step 5 — Install + Start cloudflared service
```bash
sudo cloudflared service install
sudo systemctl enable cloudflared
sudo systemctl start cloudflared
```

Tunnel is now active.

---

# 4️⃣ Add Public Hostnames in Cloudflare Tunnel

Cloudflare Dashboard →  
Zero Trust →  
**Networks → Tunnels → code-tunnel → Public Hostnames**

Click **Add Public Hostname**

### Example — Docs site
**Hostname:**
```
docs.osirispc.com
```

**Service:**
```
http://192.168.199.177:8282
```

### Example — Code Server
**Hostname:**
```
code.osirispc.com
```

**Service:**
```
http://192.168.199.177:8002
```

Cloudflare automatically creates DNS CNAMEs like:
```
docs.osirispc.com → <tunnel-id>.cfargotunnel.com
```

---

# 5️⃣ Protect Applications With Cloudflare Access

Cloudflare Dashboard →  
Zero Trust →  
**Access → Applications → Add Application**

Select **Self-hosted**.

---

## Example — Protect docs.osirispc.com

**Application Name:**
```
docs
```

**Application Domain:**
```
docs.osirispc.com/*
```

**Policy:**
Allow → Email:
```
osirisortizpc@gmail.com
```

---

## Example — Protect code.osirispc.com

**Application Domain:**
```
code.osirispc.com/*
```

**Policy:**
Allow → Email:
```
osirisortizpc@gmail.com
```

---

# 6️⃣ Testing Cloudflare Zero Trust

## Test 1 — Visit your protected service
```
https://docs.osirispc.com
```

You should see the Cloudflare Access login.

---

## Test 2 — Identity diagnostic
Visit:
```
https://whoami.cloudflareaccess.com
```

Expected output includes:
```
isAccessGranted: true
email: your_email
```

---

## Test 3 — Check DNS resolution
Run:
```bash
dig docs.osirispc.com
```

You should see:
```
docs.osirispc.com.  CNAME  <tunnel-id>.cfargotunnel.com.
```

---

# 7️⃣ Troubleshooting

## ❌ If you get the “Welcome — no apps assigned” screen:
Cloudflare is authenticating you **but can’t match the hostname to an Access App**.

Fix:

1. Application Domain must be:
   ```
   docs.osirispc.com/*
   ```
2. Public Hostname must exist in the tunnel  
3. DNS CNAME must exist  
4. Policy must include your email

---

# 🎉 Final Notes

This page uses MkDocs Material features:

Enable code copy buttons with:
```yaml
theme:
  features:
    - content.code.copy
```

When developing documentation, fenced code blocks create automatic copy icons and styling.

---

# ✔ End of Guide