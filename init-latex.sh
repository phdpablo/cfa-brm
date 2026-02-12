#!/bin/bash

# This script regenerates LaTeX formats on first container start.
# Subsequent starts are instant (uses lock file).
# Much faster than tlmgr_update: only regenerates formats, doesn't update packages.

LOCK_FILE="/home/rstudio/.latex_fmt_synced"

if [ ! -f "$LOCK_FILE" ]; then
  echo "🔄 Syncing LaTeX formats on first run (takes ~30-40 seconds)..."
  fmtutil-sys --all > /dev/null 2>&1
  touch "$LOCK_FILE"
  echo "✅ LaTeX formats synced."
else
  echo "✅ LaTeX already synced."
fi

# Start the main RStudio process
exec /init
