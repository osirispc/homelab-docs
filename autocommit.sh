#!/bin/bash
# Homelab Docs Auto-Commit Script — pacard-sawmill (conflict-safe)

cd ~/projects/homelab-docs || exit
LOGFILE=~/projects/homelab-docs/autocommit.log
LOCKFILE=/tmp/homelab_autocommit.lock
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Prevent overlap
if [ -f "$LOCKFILE" ]; then
  echo "[$timestamp] Another commit in progress. Skipping run." >> "$LOGFILE"
  exit 0
fi
trap "rm -f $LOCKFILE" EXIT
touch "$LOCKFILE"

echo "[$timestamp] Running autocommit..." >> "$LOGFILE"

git fetch origin main --quiet
git reset --soft origin/main

git add -A

if git diff --cached --quiet; then
  echo "[$timestamp] No changes to commit." >> "$LOGFILE"
else
  git commit -m "Auto-update: $timestamp" >> "$LOGFILE" 2>&1
  git pull --rebase origin main >> "$LOGFILE" 2>&1
  git push >> "$LOGFILE" 2>&1
  echo "[$timestamp] Changes committed and pushed." >> "$LOGFILE"
fi

# Trim log to last 50 lines
MAX_LINES=50
LINE_COUNT=$(wc -l < "$LOGFILE")
if [ "$LINE_COUNT" -gt "$MAX_LINES" ]; then
  tail -n "$MAX_LINES" "$LOGFILE" > "${LOGFILE}.tmp"
  mv "${LOGFILE}.tmp" "$LOGFILE"
  echo "[$timestamp] Log trimmed to last $MAX_LINES lines." >> "$LOGFILE"
fi

