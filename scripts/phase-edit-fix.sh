#!/usr/bin/env bash
# Phase runner for "Edit/Fix" workflow (existing app).
# Usage: ./scripts/phase-edit-fix.sh <phase-number>

set -euo pipefail
cd "$(dirname "$0")/.."

phase="${1:-}"
if [ -z "$phase" ]; then
  echo "Usage: $0 <phase-number>"
  echo "Phases:"
  echo "  1  Map Sync (check-map-fresh.sh → codebase-map sync if needed)"
  echo "  2  Explore/Grill (grill-with-docs or grilling skill)"
  echo "  3  Plan Fix (to-spec skill for small fix, or direct)"
  echo "  4  Implement Fix (tdd or direct)"
  exit 1
fi

case "$phase" in
  1)
    echo "=== Phase 1: Map Sync ==="
    ./scripts/check-map-fresh.sh
    echo "If changes shown, run via agent: \"Scope: app. Run codebase-map sync.\""
    ;;
  2)
    echo "=== Phase 2: Explore/Grill ==="
    echo "Run via agent: \"Scope: app. Use grill-with-docs (or grilling) to explore the issue.\""
    echo "Agent identifies root cause, scope, affected files"
    ;;
  3)
    echo "=== Phase 3: Plan Fix ==="
    echo "For small fix: agent proposes plan directly."
    echo "For complex fix: run via agent: \"Scope: app. Use to-spec for the fix plan.\""
    echo "Agent creates fix plan with affected files, tests needed"
    ;;
  4)
    echo "=== Phase 4: Implement Fix ==="
    echo "Run via agent: \"Scope: app. Implement the fix with tdd.\""
    echo "Fix, tests, map updates, definition-of-done."
    ;;
  *)
    echo "Unknown phase: $phase"
    exit 1
    ;;
esac