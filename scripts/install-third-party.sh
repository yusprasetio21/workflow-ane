#!/usr/bin/env bash
# Phase 3 (New App) or Phase 1 (Existing App): Install third-party skills.
# Run ONLY after workflow-interview presents plan and user approves this phase.
# By default installs mattpocock core process (7 skills).
# Use --with-style to also install caveman + ponytail.

set -euo pipefail
cd "$(dirname "$0")/.."

WITH_STYLE=0
for arg in "$@"; do
  case "$arg" in
    --with-style) WITH_STYLE=1 ;;
    *) echo "Unknown arg: $arg"; exit 1 ;;
  esac
done

ok(){ echo "[ok]   $*"; }
warn(){ echo "[warn] $*"; }
err(){ echo "[err]  $*" >&2; }

command -v git >/dev/null || { err "git required"; exit 1; }
command -v rg >/dev/null || { err "ripgrep required"; exit 1; }

MANIFEST="third-party.manifest"
LOCK="third-party.lock"
TMP="$(mktemp -d)"
NEWLOCK="$(mktemp)"
GIT_BASE="https://github.com"
UPDATE=0  # 0 = use pinned commits from lock

cleanup() { rm -rf "$TMP" "$NEWLOCK"; }
trap cleanup EXIT

locked_commit() {
  grep "^$1 " "$LOCK" 2>/dev/null | awk '{print $2}' || true
}

fetch_repo() {
  local repo="$1" slug dir ref pinned
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
  fi
  CLONE="$dir"
}

install_skill() {
  local repo="$1" skill_name="$2"
  fetch_repo "$repo"
  local skill_dir="$CLONE/$skill_name"
  if [ ! -d "$skill_dir" ] || [ ! -f "$skill_dir/SKILL.md" ]; then
    err "Skill folder '$skill_name' not found or missing SKILL.md in $repo"
    return 1
  fi
  mkdir -p ".agents/skills/$skill_name"
  cp -r "$skill_dir/"* ".agents/skills/$skill_name/"
  # Copy license if exists
  for lic in "$CLONE/LICENSE" "$CLONE/LICENSE.md" "$CLONE/LICENSE.txt"; do
    [ -f "$lic" ] && cp "$lic" "LICENSES/${repo//\//__}-LICENSE" && break
  done
  ok "installed: $skill_name  <-  $repo"
}

# Parse manifest
while IFS= read -r line; do
  line="${line%%#*}"  # strip comments
  line="$(echo "$line" | xargs)"  # trim
  [ -z "$line" ] && continue
  set -- $line
  repo="$1"
  skill="$2"
  case "$repo" in
    DietrichGebert/ponytail|JuliusBrussee/caveman)
      [ "$WITH_STYLE" -eq 1 ] || { warn "skipping style skill $skill (use --with-style)"; continue; }
      ;;
  esac
  install_skill "$repo" "$skill"
done < "$MANIFEST"

mv "$NEWLOCK" "$LOCK"
ok "Pinned commits updated in $LOCK"

n="$(find .agents/skills -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
ok "$n total skills in .agents/skills"

echo
echo "✅ Third-party skills installed. Next phase per your approved plan."
echo "👉 Tell your agent: \"Phase 3 approved. Proceed to Phase 4.\""