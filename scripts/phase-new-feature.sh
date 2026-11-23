#!/usr/bin/env bash
# Phase runner for "New Feature" workflow (existing app).
# Usage: ./scripts/phase-new-feature.sh <phase-number>

set -euo pipefail
cd "$(dirname "$0")/.."

phase="${1:-}"
if [ -z "$phase" ]; then
  echo "Usage: $0 <phase-number>"
  echo "Phases:"
  echo "  1  Map Sync (check-map-fresh.sh → codebase-map sync if needed)"
  echo "  2  Grill Requirements (grill-with-docs skill)"
  echo "  3  Feature Spec (feature-spec skill)"
  echo "  4  Break Down (to-tickets skill)"
  echo "  5  Implement (tdd per task)"
  exit 1
fi

case "$phase" in
  1)
    echo "=== Phase 1: Map Sync ==="
    ./scripts/check-map-fresh.sh
    echo "If changes shown, run via agent: \"Scope: app. Run codebase-map sync.\""
    ;;
  2)
    echo "=== Phase 2: Grill Requirements ==="
    echo "Run via agent: \"Scope: app. Use grill-with-docs for this feature.\""
    echo "Agent clarifies requirements, updates GLOSSARY.md"
    ;;
  3)
    echo "=== Phase 3: Feature Spec ==="
    echo "Run via agent: \"Scope: app. Use feature-spec for: <feature description>.\""
    echo "Agent creates docs/features/<slug>.md with impact analysis"
    ;;
  4)
    echo "=== Phase 4: Break Down ==="
    echo "Run via agent: \"Scope: app. Use to-tickets for the approved spec.\""
    echo "Agent creates ordered tasks with verification steps"
    ;;
  5)
    echo "=== Phase 5: Implement ==="
    echo "Run via agent per task: \"Scope: app. Implement task N with tdd.\""
    echo "Each task: code, tests, map updates, definition-of-done."
    ;;
  *)
    echo "Unknown phase: $phase"
    exit 1
    ;;
esac