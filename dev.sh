#!/bin/bash
# activate venv
source .venv/bin/activate

# kill any mkdocs servers running
pkill -f "mkdocs serve"

# start fresh on a guaranteed port
mkdocs serve -a 127.0.0.1:7777
