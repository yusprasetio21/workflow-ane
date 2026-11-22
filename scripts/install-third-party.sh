#!/usr/bin/env bash
# Install the skills listed in third-party.manifest into .agents/skills/
# and pin the repos' commits in third-party.lock. Needs git and internet.
# Usage: scripts/install-third-party.sh [--update]
set -euo pipefail
cd "$(dirname "$0")/.."

MANIFEST="third-party.manifest"
LOCK="third-party.lock"
DEST=".agents/skills"
GIT_BASE="${GIT_BASE:-https://github.com}"
OWN=" codebase-map feature-spec ui-migration definition-of-done design-system "
UPDATE=0
[ "${1:-}" = "--update" ] && UPDATE=1

command -v git >/dev/null || { echo "git is required"; exit 1; }
[ -f "$MANIFEST" ] || { echo "Missing $MANIFEST"; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$DEST" LICENSES
NEWLOCK="$TMP/lock.new"
: > "$NEWLOCK"
CLONE=""

locked_commit() {
  [ -f "$LOCK" ] && awk -v r="$1" '$1==r {print $2; exit}' "$LOCK" || true
}

fetch_repo() {
  local repo="$1" slug dir ref pinned f
  slug="${repo//\//__}"
  dir="$TMP/$slug"
  if [ ! -d "$dir" ]; then
    ref="HEAD"
    if [ "$UPDATE" -eq 0 ]; then
      pinned="$(locked_commit "$repo")"
      [ -n "$pinned" ] && ref="$pinned"
    fi
    git init -q "$dir"
    git -C "$dir" remote add origin "$GIT_BASE/$repo.git"
    git -C "$dir" fetch -q --depth 1 origin "$ref"
    git -C "$dir" checkout -q FETCH_HEAD
    printf '%s %s %s\n' "$repo" "$(git -C "$dir" rev-parse HEAD)" "$(date -u +%F)" >> "$NEWLOCK"
    shopt -s nullglob
    for f in "$dir"/LICENSE*; do cp "$f" "LICENSES/${slug}-$(basename "$f")"; done
    shopt -u nullglob
  fi
  CLONE="$dir"
}

while read -r repo skill _; do
  [ -z "${repo:-}" ] && continue
  case "$repo" in \#*) continue ;; esac
  [ -z "${skill:-}" ] && { echo "Bad manifest line for $repo"; exit 1; }
  case "$OWN" in *" $skill "*) echo "ERROR: '$skill' is one of your own skills; rename or remove it from the manifest"; exit 1 ;; esac
  fetch_repo "$repo"
  mapfile -t found < <(find "$CLONE" -type d -name "$skill" -not -path '*/.git/*' -exec test -f '{}/SKILL.md' \; -print)
  if [ "${#found[@]}" -ne 1 ]; then
    echo "ERROR: $repo / $skill: expected exactly 1 folder with SKILL.md, found ${#found[@]}"
    [ "${#found[@]}" -gt 0 ] && printf '  %s\n' "${found[@]}"
    exit 1
  fi
  rm -rf "${DEST:?}/$skill"
  cp -a "${found[0]}" "$DEST/$skill"
  echo "installed: $skill  <-  $repo"
done < "$MANIFEST"

sort -u "$NEWLOCK" > "$LOCK"
echo
echo "Pinned in $LOCK:"; cat "$LOCK"
echo
echo "NEXT: read each .agents/skills/<name>/SKILL.md before using it."
