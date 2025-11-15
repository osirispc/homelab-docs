#!/bin/bash
cd ~/projects/homelab-docs || exit

LOGFILE=~/projects/homelab-docs/autocommit.log
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$timestamp] Running autocommit..." >> "$LOGFILE"

git add -A

# Try committing; if nothing to commit, log that too
if git diff --cached --quiet; then
  echo "[$timestamp] No changes to commit." >> "$LOGFILE"
else
  git commit -m "Auto-update: $timestamp" >> "$LOGFILE" 2>&1
  git push >> "$LOGFILE" 2>&1
  echo "[$timestamp] Changes committed and pushed." >> "$LOGFILE"
fi
