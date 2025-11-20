#!/bin/bash
# deploy-homelab.sh
# Deploy Homelab Docs to production (docs.osirispc.com)

set -e

PROJECT_DIR="$HOME/projects/homelab-docs"
SITE_DIR="$PROJECT_DIR/site"
TARGET_DIR="/var/www/html/homelab"

echo "[*] Activating virtual environment..."
source "$PROJECT_DIR/.venv/bin/activate"

echo "[*] Building documentation..."
mkdocs build

echo "[*] Preparing production directory..."
sudo mkdir -p "$TARGET_DIR"

echo "[*] Copying built site to production..."
sudo rsync -av --delete "$SITE_DIR/" "$TARGET_DIR/"

echo "[*] Setting permissions..."
sudo chown -R www-data:www-data "$TARGET_DIR"

echo "[*] Reloading NGINX..."
sudo systemctl reload nginx

echo "[✓] Deployment complete!"
