#!/usr/bin/env bash
# Informational (never fails): how far the app moved since the commit recorded
# in map/INDEX.md ("Verified commits" table).
# Usage: scripts/check-map-fresh.sh [--quiet]
set -uo pipefail
cd "$(dirname "$0")/.."
INDEX="map/INDEX.md"
QUIET=0
while [ $# -gt 0 ]; do
  case "$1" in
    --quiet) QUIET=1 ;;
  esac
  shift
done
[ -f "$INDEX" ] || { [ "$QUIET" -eq 1 ] || echo "No $INDEX"; exit 0; }

rows="$(awk -F'|' '
  /^## Verified commits/ {f=1; next}
  /^## / {f=0}
  f && /^\|/ {
    for (i=2;i<=5;i++) gsub(/[ \t]/,"",$i)
    if ($2=="App" || $2 ~ /^-+$/) next
    print $2, $3, $4, $5
  }' "$INDEX")"

[ -n "$rows" ] || { [ "$QUIET" -eq 1 ] || echo "No rows in Verified commits."; exit 0; }

while read -r app folder branch commit; do
  if [ "$commit" = "-" ] || [ -z "$commit" ]; then
    [ "$QUIET" -eq 1 ] || echo "[$app] no commit recorded: map not initialized for this app"
    continue
  fi
  if [ ! -d "$folder/.git" ] && ! git -C "$folder" rev-parse >/dev/null 2>&1; then
    echo "[$app] folder '$folder' is not a git repo or is missing"
    continue
  fi
  if ! git -C "$folder" cat-file -e "${commit}^{commit}" 2>/dev/null; then
    echo "[$app] recorded commit $commit not found (history rewritten or not fetched): treat map as unverified"
    continue
  fi
  n="$(git -C "$folder" diff --name-only "$commit"..HEAD | wc -l | tr -d ' ')"
  cur="$(git -C "$folder" rev-parse --abbrev-ref HEAD 2>/dev/null)"
  note=""
  [ "$cur" != "$branch" ] && [ "$branch" != "-" ] && note=" (branch now '$cur', recorded '$branch')"
  if [ "$n" -eq 0 ]; then
    [ "$QUIET" -eq 1 ] || echo "[$app] up to date at ${commit:0:8}$note"
  else
    echo "[$app] $n file(s) changed since ${commit:0:8}$note. Run codebase-map (sync). First 15:"
    git -C "$folder" diff --name-only "$commit"..HEAD | head -15 | sed 's/^/    /'
  fi
done <<< "$rows"
exit 0
