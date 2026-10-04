#!/usr/bin/env bash
# Render report/report.html to PDF with headless Google Chrome.
set -euo pipefail
cd "$(dirname "$0")"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
OUT="${1:-DDM501_Assignment1_StudentID_Name.pdf}"
"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$PWD/$OUT" "file://$PWD/report/report.html" 2>/dev/null
echo "Wrote $OUT"
