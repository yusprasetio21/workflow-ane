#!/usr/bin/env bash
# UI Audit for Flutter (Dart): counts design values currently used.
# No AI. Needs ripgrep (rg).
# Usage: scripts/ui-audit.sh [path]   (default: apps/app/lib)
set -uo pipefail
cd "$(dirname "$0")/.."
SRC="${1:-apps/app/lib}"
command -v rg >/dev/null || { echo "ripgrep (rg) is required: sudo apt install ripgrep"; exit 1; }
[ -d "$SRC" ] || { echo "Not found: $SRC"; exit 1; }
OUT="docs/ui-audit.txt"
{
  echo "# UI Audit of $SRC  ($(date -u +%F))"
  echo
  echo "## Hex colors (top 60)"
  rg -o --no-filename -g '*.dart' '#[0-9a-fA-F]{3,8}\b' "$SRC" \
    | tr 'A-F' 'a-f' | sort | uniq -c | sort -rn | head -60
  echo
  sec() { echo "## $1 (top ${3:-40})"; rg -o --no-filename -g '*.dart' "$2" "$SRC" | sed 's/[[:space:]]\+/ /g' | sort | uniq -c | sort -rn | head -"${3:-40}"; }
  sec "Color constructors" 'Color\(0x[0-9a-fA-F]{8}\)' 40
  sec "Colors." 'Colors\.\w+' 30
  sec "Theme.of" 'Theme\.of\(context\)' 30
  sec "ThemeData" 'ThemeData\(' 15
  sec "ColorScheme" 'ColorScheme\.' 20
  sec "TextStyle" 'TextStyle\(' 30
  sec "fontSize" 'fontSize:\s*[^,)]+' 30
  sec "fontWeight" 'fontWeight:\s*[^,)]+' 15
  sec "fontFamily" 'fontFamily:\s*[^,)]+' 15
  sec "height" 'height:\s*[^,)]+' 15
  sec "BorderRadius" 'BorderRadius\.' 30
  sec "BoxShadow" 'BoxShadow\(' 30
  sec "Duration" 'Duration\(milliseconds:\s*[^,)]+' 30
  sec "Curve" 'Curves\.' 30
  sec "padding/margin" '(padding|margin):\s*[^,)]+' 40
  sec "EdgeInsets" 'EdgeInsets\.' 30
  echo
  echo "## const usage count (should be high)"
  rg -c '\bconst\s' -g '*.dart' "$SRC" | awk -F: '{s+=$2} END {print s+0}'
  echo
  echo "## Component candidates (Dart files in lib/components/ with usage count)"
  find "$SRC/components" -name '*.dart' -type f 2>/dev/null | while read -r f; do
    base="$(basename "$f" .dart)"
    cnt=$(rg -c "(import.*${base}|${base}\()" -g '*.dart' "$SRC" 2>/dev/null | awk -F: '{s+=$2} END {print s+0}')
    echo "  $base.dart  ->  used ~${cnt:-0} times"
  done | sort -k3 -rn
} | tee "$OUT"
echo
echo "Saved to $OUT. Paste it to your design chat to decide the token scale."