#!/usr/bin/env bash
# Phase 1: Basic workspace setup (no third-party skills, no maps).
# Run ONLY after workflow-interview presents plan and user approves Phase 1.
# Idempotent; changes nothing outside this folder.

set -euo pipefail
cd "$(dirname "$0")/.."

ok(){ echo "[ok]   $*"; }
warn(){ echo "[warn] $*"; }

command -v git >/dev/null && ok "git" || { echo "git is required"; exit 1; }
if command -v node >/dev/null; then
  major="$(node -p 'process.versions.node.split(".")[0]')"
  [ "$major" -ge 22 ] && ok "node $(node -v)" || warn "node $(node -v) (<22): some tools may need 22+"
else warn "node not found (needed for MCP servers that run via npx)"; fi
command -v rg >/dev/null && ok "ripgrep" || warn "ripgrep missing (needed by scripts/ui-audit.sh): sudo apt install ripgrep"

[ -f .env ] || { cp .env.example .env; ok "created .env: fill in your API keys"; }
ln -sfn AGENTS.md .goosehints && ok ".goosehints -> AGENTS.md"
chmod +x scripts/*.sh .githooks/* 2>/dev/null || true
if git rev-parse --git-dir >/dev/null 2>&1; then
  git config core.hooksPath .githooks && ok "git hooks enabled (.githooks)"
else warn "not a git repo yet: run 'git init' then re-run this script"; fi

n="$(find .agents/skills -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
ok "$n skills in .agents/skills (custom only; third-party installed in later phase)"

[ -d "apps/app" ] && ok "apps/app present" || warn "apps/app missing: place your source code there (see apps/README.md)"

echo
echo "✅ Phase 1 complete. Next phase per your approved plan."
echo "👉 Tell your agent: \"Phase 1 approved. Proceed to Phase 2.\""