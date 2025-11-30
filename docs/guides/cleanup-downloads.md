# 🧹 Automated Downloads Cleanup (RARR Stack)

Your automated cleanup system on **thewhitelodge** removes old, completed downloads from:

/mnt/data/downloads

while *preserving*:

- 🟪 `/mnt/data/downloads/incomplete/`
- 🆕 Newly imported items
- 🗓️ Anything younger than **3 days** (configurable)

This prevents clutter, saves storage, and keeps Radarr/Sonarr working smoothly.

---

## 📁 Directory Structure

Your downloads share is laid out like:

/mnt/data/downloads ├── incomplete/      # DO NOT DELETE — active downloads ├── Movie1/ ├── Movie2/ ├── TV Show/ └── Other items...

Everything **except** `incomplete/` is eligible for cleanup once it's older than **X** days.

---

## 🧽 Cleanup Script

### 📍 Script Location

/usr/local/bin/cleanup-downloads.sh

### 📝 Script Contents

```bash
#!/bin/bash
# cleanup-downloads.sh
# Automatically clean up completed RARR downloads older than X days.

DOWNLOADS_DIR="/mnt/data/downloads"
INCOMPLETE_NAME="incomplete"
LOGFILE="/var/log/cleanup-downloads.log"
DAYS_OLD=3   # Delete items older than X days

echo "===== Cleanup run: $(date) =====" >> "$LOGFILE"

find "$DOWNLOADS_DIR" \
  -mindepth 1 \
  -maxdepth 1 \
  ! -name "$INCOMPLETE_NAME" \
  -type d \
  -mtime +"$DAYS_OLD" \
  -print -exec rm -rf {} \; >> "$LOGFILE" 2>&1

echo "Cleanup complete." >> "$LOGFILE"

🔐 Set Permissions

sudo chmod +x /usr/local/bin/cleanup-downloads.sh


---

⏱️ Enable Nightly Cron Job (2:00 AM)

Open the root crontab:

sudo crontab -e

Add:

0 2 * * * /usr/local/bin/cleanup-downloads.sh


---

🧪 Testing & Verification

▶️ Run Manually

sudo /usr/local/bin/cleanup-downloads.sh

🧐 Dry Run (See What WOULD Be Deleted)

sudo find /mnt/data/downloads \
  -mindepth 1 \
  -maxdepth 1 \
  ! -name incomplete \
  -type d \
  -mtime +3 \
  -print

📄 Check Logs

/var/log/cleanup-downloads.log

Tail:

tail -n 50 /var/log/cleanup-downloads.log


---

🪵 Change Log

2025-11-30 — Initial version

Added X-day retention

Cleanup exclusions

Crontab automation

Logging support


---

Agent…  
This formatting now matches **exactly** the clean procedural style from your Unbound page — headers, spacing, icons, copy-ready blocks, the works.

If you'd like, I can now:

✅ Generate the matching **mkdocs.yml navigation entry**  
✅ Create a **Twin Peaks–themed variant**  
✅ Add this to your **homelab-docs repo** layout you use everywhere  

Just say the word.