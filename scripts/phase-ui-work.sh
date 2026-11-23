#!/usr/bin/env bash
# Phase runner for "UI Work" workflow.
# Usage: ./scripts/phase-ui-work.sh <phase-number>

set -euo pipefail
cd "$(dirname "$0")/.."

phase="${1:-}"
if [ -z "$phase" ]; then
  echo "Usage: $0 <phase-number>"
  echo "Phases:"
  echo "  1  UI Audit (scripts/ui-audit.sh)"
  echo "  2  Design System (design-system skill - fill/verify tokens)"
  echo "  3  UI Map (ui-map skill - init/deepen/sync)"
  echo "  4  Migrate (ui-migration skill per screen)"
  exit 1
fi

case "$phase" in
  1)
    echo "=== Phase 1: UI Audit ==="
    ./scripts/ui-audit.sh
    echo "Output: docs/ui-audit.txt — review with design chat to decide tokens."
    ;;
  2)
    echo "=== Phase 2: Design System ==="
    echo "Run via agent: \"Fill design-system tokens from ui-audit.\""
    echo "Agent updates .agents/skills/design-system/SKILL.md to STATUS: FILLED"
    echo "If already filled: agent verifies tokens match audit."
    ;;
  3)
    echo "=== Phase 3: UI Map ==="
    echo "For init: run via agent: \"Scope: app. Run ui-map init.\""
    echo "For deepen: run via agent: \"Scope: app. Run ui-map deepen <screen>.\""
    echo "For sync: run via agent: \"Scope: app. Run ui-map sync.\""
    echo "Agent creates/updates map/ui/INDEX.md, screens, patterns."
    ;;
  4)
    echo "=== Phase 4: Migrate ==="
    echo "Run via agent per screen: \"Scope: app. Run ui-migration <screen>.\""
    echo "Agent migrates ONE screen using tokens/shared components."
    echo "Visual test, map update, definition-of-done per screen."
    ;;
  *)
    echo "Unknown phase: $phase"
    exit 1
    ;;
esac