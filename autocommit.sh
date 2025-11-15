#!/bin/bash
cd ~/projects/homelab-docs || exit

git add -A

timestamp=$(date +"%Y-%m-%d %H:%M:%S")
git commit -m "Auto-update: $timestamp" >/dev/null 2>&1

git push >/dev/null 2>&1
