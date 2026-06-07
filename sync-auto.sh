#!/bin/bash
cd ~/.claude
git add settings.json projects/-Users-erocha/memory/ 2>/dev/null
if ! git diff --cached --quiet 2>/dev/null; then
    git commit -m "sync auto $(date '+%Y-%m-%d %H:%M')" --quiet 2>/dev/null
    git push origin main --quiet 2>/dev/null
fi
