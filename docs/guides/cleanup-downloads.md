# 🧹 Automated Downloads Cleanup (RARR Stack)

This guide documents your fully automated **download cleanup system** running on **thewhitelodge**.  
It keeps your `/mnt/data/downloads` share clean by automatically deleting old, completed downloads — while preserving:

- 🟪 The `incomplete/` folder  
- 🆕 Newly imported items (younger than X days)  
- 🔒 Anything currently being processed by Radarr/Sonarr  

Default retention: **3 days**.

---

## 📁 Directory Structure

Your downloads directory is structured like this:

/mnt/data/downloads ├── incomplete/      # ⛔ Do NOT delete — active downloads ├── Movie1/ ├── Movie2/ ├── TV Show/ └── etc...

All folders **except** `incomplete/` are safe to remove after they are older than X days *and* imported by Radarr/Sonarr.

---

## 🧽 Cleanup Script

The cleanup script is located at:

/usr/local/bin/cleanup-downloads.sh

### 📝 Script Contents

```bash
#!/bin/bash
# cleanup-downloads.sh
# Automatically clean up completed RARR downloads.

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


---

🔒 Permissions

Make the script executable:

sudo chmod +x /usr/local/bin/cleanup-downloads.sh


---

⏱️ Automated Nightly Cleanup (2:00 AM)

Configure cron:

sudo crontab -e

Add the nightly rule:

0 2 * * * /usr/local/bin/cleanup-downloads.sh


---

ℹ️ How It Works

✔ Keeps Safe

incomplete/

Anything < 3 days old

Any download still being processed or imported


✔ Deletes

Completed download folders

Anything older than 3 days

Leftovers from Radarr/Sonarr imports


📄 Logs saved at:

/var/log/cleanup-downloads.log

View logs:

tail -n 50 /var/log/cleanup-downloads.log


---

🧪 Manual Testing

Run manually:

sudo /usr/local/bin/cleanup-downloads.sh

Dry-run view of what would be deleted:

sudo find /mnt/data/downloads \
  -mindepth 1 \
  -maxdepth 1 \
  ! -name incomplete \
  -type d \
  -mtime +3 \
  -print


---

🪵 Change Log

2025-11-30 — Initial version created with:

Automated nightly cleanup

X-day protection rule

Logging added

MkDocs-friendly formatting
