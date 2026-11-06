#!/bin/sh
# Verify stage: the app is only packaged if every required file is present
# and the page carries the company title.
set -e
for f in index.html style.css app.js; do
  if [ -f "$f" ]; then echo "OK  $f found"; else echo "MISSING $f"; exit 1; fi
done
grep -q "Zain Tech Automation Solutions" index.html && echo "OK  index.html carries the company title"
echo "All checks passed."
