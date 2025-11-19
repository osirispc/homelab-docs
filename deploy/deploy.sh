#!/bin/bash
echo "🌀 Syncing changes..."
cd ..

echo "🛠️  Rebuilding production docs..."
docker exec mkdocs-homelab mkdocs build --clean

echo "🌲 Done! Production docs updated."
