## Network Baseline: Pi-hole 1 Configuration (Operational as of Nov 16, 2025)

### 🧩 Overview

Pi-hole 1 (192.168.199.53) is now operating as the **primary DNS server** for the network. The secondary DNS has been left as Cloudflare (1.1.1.1) temporarily for redundancy during observation.

---

### 🌐 Router DHCP Configuration (TP-Link)

**DHCP Server:** Enabled
**IP Address Pool:** `192.168.199.99 – 192.168.199.201`
**Address Lease Time:** 120 minutes
**Default Gateway:** `192.168.199.1`
**Primary DNS:** `192.168.199.53` (Pi-hole 1)
**Secondary DNS:** `1.1.1.1` (Cloudflare, temporary fallback)

---

### 🧠 Pi-hole 1 Details

* **Status:** Running normally
* **IP Address:** `192.168.199.53`
* **Role:** Primary DNS server for LAN
* **Container health:** Healthy (FTL process active)
* **DNS test results:** Successful resolution via `nslookup google.com 192.168.199.53`

---

### 🕵️ Monitoring Instructions (48-hour observation)

1. **UI → Query Log:** Confirm steady traffic and minimal “retried” queries.
2. **UI → Tools → Network:** Verify active client list is populating.
3. From any LAN host:

   ```bash
   nslookup cloudflare.com 192.168.199.53
   ```

   * Should return valid IPv4/IPv6 results quickly.
4. If browsing stalls:

   ```bash
   pihole -t
   ```

   * Use this to tail real-time logs and confirm query flow.

---

### 🪶 Next Steps (after stability confirmed)

Once Pi-hole 1 proves stable:

* Deploy **new Unbound server** on a clean VM (not `.139`).
* Integrate Pi-hole 1 with that Unbound for recursive resolution.
* Remove Cloudflare fallback (1.1.1.1) to enforce full DNS filtering.

---

### ⚙️ Next Change Procedure: Switching to Recursive Unbound

1. **Deploy Unbound Container:**

   ```bash
   docker run -d --name unbound \
     -p 5335:5335/tcp \
     -p 5335:5335/udp \
     -v /opt/unbound/etc:/etc/unbound \
     --restart unless-stopped \
     mvance/unbound:latest
   ```

2. **Update Pi-hole Upstream DNS in UI:**
   Go to **Settings → DNS → Upstream DNS Servers** and set:

   ```
   Custom 1 (IPv4): 127.0.0.1#5335
   ```

3. **Disable Cloudflare Fallback:**
   Remove `1.1.1.1` from your router’s DHCP config.

4. **Verify with dig/nslookup:**

   ```bash
   dig google.com @127.0.0.1 -p 5335
   ```

   If that resolves, Unbound is active.

5. **Reboot Clients or Flush DNS:**

   ```bash
   ipconfig /flushdns   # Windows
   sudo systemd-resolve --flush-caches  # Linux
   ```

6. **Monitor Logs:**

   ```bash
   docker logs -f unbound
   pihole -t
   ```

Once Unbound has stable recursion, log the new baseline as *Phase 2: Recursive DNS*.

---

### ✅ Current State Summary

| Component      | IP Address     | Role                     | Status      |
| -------------- | -------------- | ------------------------ | ----------- |
| TP-Link Router | 192.168.199.1  | Gateway & DHCP           | Active      |
| Pi-hole 1      | 192.168.199.53 | Primary DNS              | Operational |
| Cloudflare     | 1.1.1.1        | Secondary DNS (Fallback) | Enabled     |

---

*Documented by Agent Osiris – maintained in the Lodge Systems Logbook*

