#!/usr/bin/env bash
# Entry point for workflow-ane template.
# Runs the mandatory interview FIRST, then executes approved phases.
# Usage: ./scripts/start.sh

set -euo pipefail
cd "$(dirname "$0")/.."

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║  workflow-ane — AI-Assisted Development Template             ║"
echo "║  Indonesian personal branding • Token-efficient • Transparent ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo

# Check if workflow-interview skill exists
if [ ! -f ".agents/skills/workflow-interview/SKILL.md" ]; then
  echo "❌ Missing workflow-interview skill. Template may be corrupted."
  exit 1
fi

echo "📋 MANDATORY INTERVIEW — This runs before ANY setup or work."
echo "   The agent will ask 3 questions, then present a phased plan."
echo "   You approve each phase gate before execution."
echo
echo "👉 Start a NEW AGENT SESSION in this folder and send:"
echo
echo "   \"Run workflow-interview skill. I want to start.\""
echo
echo "   The agent will conduct the interview and present the plan."
echo
echo "═══════════════════════════════════════════════════════════════"
echo "QUICK REFERENCE — Workflow Types:"
echo "  1. New App       — Greenfield project, choose stack, full setup"
echo "  2. New Feature   — Add feature to existing app in apps/"
echo "  3. Edit/Fix      — Bug fix, refactor, update existing code"
echo "  4. UI Work       — Design system, audit, migrate screens"
echo "  5. Other         — Custom workflow"
echo "═══════════════════════════════════════════════════════════════"
echo
echo "After interview approval, phases execute with explicit gates:"
echo "  Phase 1 → you approve → Phase 2 → you approve → ..."
echo
echo "Third-party skills (mattpocock core 7) install ONLY when plan says so."
echo "Style skills (caveman/ponytail) ONLY if you explicitly request."
echo
echo "📖 Full validation suite: docs/TRYOUT.md"
echo "🛠  Agent setup guide:   docs/AGENT-SETUP.md"