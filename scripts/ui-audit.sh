#!/usr/bin/env bash
# UI Audit for Vue + SCSS: counts design values currently used.
# No AI. Needs ripgrep (rg).
# Usage: scripts/ui-audit.sh [path]   (default: apps/app/src)
set -uo pipefail
cd "$(dirname "$0")/.."
SRC="${1:-apps/app/src}"
command -v rg >/dev/null || { echo "ripgrep (rg) is required: sudo apt install ripgrep"; exit 1; }
[ -d "$SRC" ] || { echo "Not found: $SRC"; exit 1; }
OUT="docs/ui-audit.txt"
{
  echo "# UI Audit of $SRC  ($(date -u +%F))"
  echo
  echo "## Hex colors (top 60)"
  rg -o --no-filename -g '*.{scss,vue,css}' '#[0-9a-fA-F]{3,8}\b' "$SRC" \
    | tr 'A-F' 'a-f' | sort | uniq -c | sort -rn | head -60
  echo
  sec() { echo "## $1 (top ${3:-40})"; rg -o --no-filename -g '*.{scss,vue,css}' "$2" "$SRC" | sed 's/[[:space:]]\+/ /g' | sort | uniq -c | sort -rn | head -"${3:-40}"; }
  sec "rgb/rgba/hsl" '(rgba?|hsla?)\([^)]*\)' 40
  sec "font-size" 'font-size:\s*[^;]+' 30
  sec "font-family" 'font-family:\s*[^;]+' 15
  sec "font-weight" 'font-weight:\s*[^;]+' 15
  sec "line-height" 'line-height:\s*[^;]+' 15
  sec "border-radius" 'border-radius:\s*[^;]+' 30
  sec "box-shadow" 'box-shadow:\s*[^;]+' 30
  sec "transition" 'transition:\s*[^;]+' 30
  sec "animation" 'animation(-name|-duration|-timing-function)?:\s*[^;]+' 30
  sec "padding/margin/gap" '(padding|margin|gap):\s*[^;]+' 40
  sec "z-index" 'z-index:\s*[^;]+' 15
  sec "opacity" 'opacity:\s*[^;]+' 15
  echo
  echo "## !important count"
  rg -c '!important' -g '*.{scss,vue,css}' "$SRC" | awk -F: '{s+=$2} END {print s+0}'
  echo
  echo "## :deep() / ::v-deep / >>> count"
  rg -c ':deep\(|::v-deep|>>>' -g '*.{scss,vue}' "$SRC" | awk -F: '{s+=$2} END {print s+0}'
  echo
  echo "## Component candidates (Vue files in src/components/ with usage count)"
  find "$SRC/components" -name '*.vue' -type f 2>/dev/null | while read -r f; do
    base="$(basename "$f" .vue)"
    # count imports/usage in other .vue files (rough)
    cnt=$(rg -c "(import.*${base}|<${base}[^a-zA-Z])" -g '*.vue' "$SRC" 2>/dev/null | awk -F: '{s+=$2} END {print s+0}')
    echo "  $base.vue  ->  used ~${cnt:-0} times"
  done | sort -k3 -rn
} | tee "$OUT"
echo
echo "Saved to $OUT. Paste it to your design chat to decide the token scale."