#!/bin/bash
# Homelab Docs Auto-Commit Script — pacard-sawmill

cd ~/projects/homelab-docs || exit

LOGFILE=~/projects/homelab-docs/autocommit.log
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$timestamp] Running autocommit..." >> "$LOGFILE"

git add -A

# Check for changes
if git diff --cached --quiet; then
  echo "[$timestamp] No changes to commit." >> "$LOGFILE"
else
  git commit -m "Auto-update: $timestamp" >> "$LOGFILE" 2>&1
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
