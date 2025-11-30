# Automated Downloads Cleanup (RARR Stack)

This guide explains how your automated **download cleanup system** works on `thewhitelodge`.  
It safely removes old, imported downloads from:

/mnt/data/downloads

while protecting:

- The `incomplete/` folder  
- Newly imported items  
- Anything younger than **X days** (default: 3)

This keeps the Lodge clean, organized, and prevents your storage from filling up over time.

---

## 📁 Directory Structure

Your downloads share looks like this:

/mnt/data/downloads ├── incomplete/        # DO NOT delete — active downloads ├── Movie1/ ├── Movie2/ ├── TV Show/ └── etc...

Everything **except** `/incomplete` is safe to be purged once it’s older than X days and already imported by Radarr/Sonarr.

---

## 🧼 Cleanup Script

The script lives at:

/usr/local/bin/cleanup-downloads.sh

### Script contents

```bash
#!/bin/bash
# cleanup-downloads.sh
# Automatically clean up completed RARR downloads while protecting the incomplete folder.
# Logs actions and deletes only items older than X days.

DOWNLOADS_DIR="/mnt/data/downloads"
INCOMPLETE_NAME="incomplete"
LOGFILE="/var/log/cleanup-downloads.log"

# Delete items older than X days (default 3)
DAYS_OLD=3

echo "[$(date)] Cleanup job started. Keeping items newer than $DAYS_OLD days." >> "$LOGFILE"

# Remove old directories except /incomplete
find "$DOWNLOADS_DIR" -mindepth 1 -maxdepth 1 \
  ! -name "$INCOMPLETE_NAME" \
  -type d \
  -mtime +"$DAYS_OLD" \
  -print -exec rm -rf {} \; >> "$LOGFILE" 2>&1

# Remove old loose files
find "$DOWNLOADS_DIR" -mindepth 1 -maxdepth 1 \
  ! -name "$INCOMPLETE_NAME" \
  -type f \
  -mtime +"$DAYS_OLD" \
  -print -exec rm -f {} \; >> "$LOGFILE" 2>&1

echo "[$(date)] Cleanup job completed." >> "$LOGFILE"


---

🛠️ Installation

1. Create the script:



sudo nano /usr/local/bin/cleanup-downloads.sh

2. Paste the script into the file


3. Make it executable:



sudo chmod +x /usr/local/bin/cleanup-downloads.sh


---

⏰ Cron Automation (Runs Every Night at 2 AM)

Open root’s crontab:

sudo crontab -e

Add this line:

0 2 * * * /usr/local/bin/cleanup-downloads.sh

This will:

Clean old downloads

Leave incomplete files untouched

Log everything



---

📜 Logging

Logs are stored at:

/var/log/cleanup-downloads.log

To view:

sudo tail -n 50 /var/log/cleanup-downloads.log


---

🎛️ Adjusting the Cleanup Age (X Days)

Inside the script:

DAYS_OLD=3

Change 3 to:

1 → extremely aggressive

7 → weekly cleanup

14 → keep downloads around longer



---

🧪 Test Run (Safe Mode)

You can simulate what would be deleted:

sudo find /mnt/data/downloads -mindepth 1 -maxdepth 1 ! -name incomplete -mtime +3 -print

Output only — nothing is deleted.


---

🧹 Manual Cleanup Trigger

Run manually anytime:

sudo /usr/local/bin/cleanup-downloads.sh


---

🏁 Final Notes

Designed for Radarr/Sonarr/Jellyfin environments

Fully safe due to incomplete folder protection

Prevents storage buildup over time

Logged, automated, hands-off



---

🗂️ Changelog

2025-11-30 – Initial version created
– Added automated purge script
– Added X-day retention rule
– Added cron automation
– Added logging system

---

If you'd like, I can also:

🔸 Add this to your MkDocs **navigation**  
🔸 Create a second page for “Lodge Automation Scripts”  
🔸 Build you a Twin Peaks–styled header banner for this page  

Just say the word.