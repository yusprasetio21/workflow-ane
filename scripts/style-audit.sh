#!/usr/bin/env bash
# Counts the style values currently used in a Vue/SCSS frontend, to decide the
# design tokens. No AI, no tokens. Needs ripgrep (rg).
# Usage: scripts/style-audit.sh [path]   (default: apps/frontend/src)
set -uo pipefail
cd "$(dirname "$0")/.."
SRC="${1:-apps/frontend/src}"
command -v rg >/dev/null || { echo "ripgrep (rg) is required: sudo apt install ripgrep"; exit 1; }
[ -d "$SRC" ] || { echo "Not found: $SRC"; exit 1; }
OUT="docs/style-audit.txt"
{
  echo "# Style audit of $SRC  ($(date -u +%F))"
  sec() { echo; echo "## $1"; rg -o --no-filename -g '*.{scss,vue,css}' "$2" "$SRC" | sed 's/[[:space:]]\+/ /g' | sort | uniq -c | sort -rn | head -"${3:-40}"; }
  echo; echo "## hex colors"; rg -o --no-filename -g '*.{scss,vue,css}' '#[0-9a-fA-F]{3,8}\b' "$SRC" | tr 'A-F' 'a-f' | sort | uniq -c | sort -rn | head -60
  sec "rgb/rgba/hsl" '(rgba?|hsla?)\([^)]*\)' 40
  sec "font-size" 'font-size:\s*[^;]+' 30
  sec "font-family" 'font-family:\s*[^;]+' 15
  sec "border-radius" 'border-radius:\s*[^;]+' 30
  sec "box-shadow" 'box-shadow:\s*[^;]+' 30
  sec "transition" 'transition:\s*[^;]+' 30
  sec "animation" 'animation(-name|-duration)?:\s*[^;]+' 30
  sec "padding/margin/gap" '(padding|margin|gap):\s*[^;]+' 40
  echo; echo "## !important count"; rg -c '!important' -g '*.{scss,vue,css}' "$SRC" | awk -F: '{s+=$2} END {print s+0}'
  echo; echo "## :deep() count"; rg -c ':deep\(|::v-deep|>>>' -g '*.{scss,vue}' "$SRC" | awk -F: '{s+=$2} END {print s+0}'
} | tee "$OUT"
echo; echo "Saved to $OUT. Paste it to your design chat to decide the token scale."
