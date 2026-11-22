#!/usr/bin/env bash
# One-time setup of this workspace. Idempotent; changes nothing outside this folder.
set -euo pipefail
cd "$(dirname "$0")/.."
ok(){ echo "[ok]   $*"; }; warn(){ echo "[warn] $*"; }

command -v git >/dev/null && ok "git" || { echo "git is required"; exit 1; }
if command -v node >/dev/null; then
  major="$(node -p 'process.versions.node.split(".")[0]')"
  [ "$major" -ge 22 ] && ok "node $(node -v)" || warn "node $(node -v) (<22): some tools may need 22+"
else warn "node not found (needed for MCP servers that run via npx)"; fi
command -v rg >/dev/null && ok "ripgrep" || warn "ripgrep missing (needed by scripts/style-audit.sh and ui-audit.sh): sudo apt install ripgrep"

[ -f .env ] || { cp .env.example .env; ok "created .env: fill in FREELLMAPI_KEY"; }
ln -sfn AGENTS.md .goosehints && ok ".goosehints -> AGENTS.md"
chmod +x scripts/*.sh .githooks/* 2>/dev/null || true
if git rev-parse --git-dir >/dev/null 2>&1; then
  git config core.hooksPath .githooks && ok "git hooks enabled (.githooks)"
else warn "not a git repo yet: run 'git init' then re-run this script"; fi

n="$(find .agents/skills -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
ok "$n skills in .agents/skills"
[ -f third-party.lock ] || warn "third-party skills not installed yet: run scripts/install-third-party.sh"
[ -d "apps/app" ] && ok "apps/app present" || warn "apps/app missing: place your source code there (see apps/README.md)"
echo
echo "Next: docs/TRYOUT.md"
echo "UI workflow: 1) scripts/ui-audit.sh  2) decide tokens  3) fill design-system  4) ui-map init  5) ui-migrate per screen"
