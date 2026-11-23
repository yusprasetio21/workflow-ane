#!/usr/bin/env bash
# Phase runner for "New App" workflow.
# Usage: ./scripts/phase-new-app.sh <phase-number>
# Each phase requires explicit user approval in the agent conversation.

set -euo pipefail
cd "$(dirname "$0")/.."

phase="${1:-}"
if [ -z "$phase" ]; then
  echo "Usage: $0 <phase-number>"
  echo "Phases:"
  echo "  1  Init Workspace (setup.sh)"
  echo "  2  Interview Stack (agent does this via workflow-interview)"
  echo "  3  Install Core Skills (install-third-party.sh)"
  echo "  4  Codebase Map Init (codebase-map skill)"
  echo "  5  UI Audit (scripts/ui-audit.sh)"
  echo "  6  Design System (design-system skill)"
  echo "  7  UI Map Init (ui-map skill)"
  echo "  8  Feature Spec (feature-spec skill)"
  echo "  9  Implement (to-spec → to-tickets → tdd)"
  exit 1
fi

case "$phase" in
  1)
    echo "=== Phase 1: Init Workspace ==="
    ./scripts/setup.sh
    ;;
  2)
    echo "=== Phase 2: Interview Stack ==="
    echo "This is done by the agent via workflow-interview skill."
    echo "Agent will ask: stack, app name, greenfield vs import."
    echo "No script to run — agent handles this."
    ;;
  3)
    echo "=== Phase 3: Install Core Skills ==="
    ./scripts/install-third-party.sh
    ;;
  4)
    echo "=== Phase 4: Codebase Map Init ==="
    echo "Run via agent: \"Scope: app. Run codebase-map init.\""
    echo "Agent creates map/INDEX.md and map/apps/app.md"
    ;;
  5)
    echo "=== Phase 5: UI Audit ==="
    ./scripts/ui-audit.sh
    echo "Output: docs/ui-audit.txt — review with design chat."
    ;;
  6)
    echo "=== Phase 6: Design System ==="
    echo "Run via agent: \"Fill design-system tokens from ui-audit.\""
    echo "Agent updates .agents/skills/design-system/SKILL.md to STATUS: FILLED"
    ;;
  7)
    echo "=== Phase 7: UI Map Init ==="
    echo "Run via agent: \"Scope: app. Run ui-map init.\""
    echo "Agent creates map/ui/INDEX.md, screens, patterns."
    ;;
  8)
    echo "=== Phase 8: Feature Spec ==="
    echo "Run via agent: \"Scope: app. Use feature-spec for: <feature description>.\""
    echo "Agent creates docs/features/<slug>.md"
    ;;
  9)
    echo "=== Phase 9: Implement ==="
    echo "Run via agent per task: to-spec → to-tickets → tdd"
    echo "Each task: code, tests, map updates, definition-of-done."
    ;;
  *)
    echo "Unknown phase: $phase"
    exit 1
    ;;
esac