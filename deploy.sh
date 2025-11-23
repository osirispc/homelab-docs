#!/bin/bash
source .venv/bin/activate
mkdocs build --clean
git add .
git commit -m "Update docs"
git push
mkdocs gh-deploy --force
