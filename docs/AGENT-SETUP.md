# Agent Setup (Goose / OpenCode / Claude Code)

## 1. API Keys
Copy `.env.example` to `.env` and fill in your provider keys:
```bash
cp .env.example .env
# Edit .env with your keys
```
Then load before starting the agent:
```bash
set -a; source .env; set +a
```

### Provider Options
- **OpenCode**: Uses `opencode.json` with OpenAI-compatible provider. Set `OPENAI_API_KEY` and `OPENAI_BASE_URL` in `.env`.
- **Goose**: Configure provider in Goose settings (OpenAI-compatible, Anthropic, etc.). `.goosehints` symlink to `AGENTS.md` is created by `setup.sh` (Phase 1).
- **Claude Code**: Uses `ANTHROPIC_API_KEY` from environment.

## 2. OpenCode Configuration
`opencode.json` at root uses a generic OpenAI-compatible provider. Run OpenCode from this folder, type `/models`, and verify the provider appears. For fair testing, select a specific model (not `auto`).

MCP servers (optional, for Context7, etc.):
```json
"mcp": {
  "context7": { "type": "local", "command": ["npx", "-y", "@upstash/context7-mcp@<pinned_version>"] }
}
```
Pin the version after testing.

## 3. Goose Configuration
- `.goosehints` is created by `setup.sh` (Phase 1) as a symlink to `AGENTS.md`.
- Connect your preferred provider (OpenAI-compatible, Anthropic, etc.) via Goose settings.
- Extensions: enable **Developer** and **Summon** (for skills). Add web search and Context7 via extension directory. Keep total active tools under 25.

## 4. MANDATORY: Workflow Interview First
**Every new session MUST start with the interview.**

### Start a New Session
1. Open your agent (Goose, OpenCode, Claude Code) in this folder.
2. Send this exact prompt:
   ```
   Run workflow-interview skill. I want to start.
   ```
3. The agent will:
   - Ask **Question 1**: Workflow type (New App / New Feature / Edit-Fix / UI Work / Other)
   - Ask **Question 2**: Context (stack, app name, feature description, etc.)
   - Present a **Phased Plan** with gates
   - Wait for your explicit "yes" to proceed

### No Autopilot
- No `setup.sh` runs until you approve Phase 1.
- No third-party skills install until you approve the phase that installs them.
- No map generation until you approve the map phase.
- You can modify, skip, or abort at any gate.

## 5. Verify Skills Load (Test A — after interview Phase 1)
In a session where Phase 1 (setup) is complete, send:
```
List the skills you can see (names only). Do not read any project files.
```
Must show: workflow-interview, codebase-map, feature-spec, ui-migration, definition-of-done, design-system, ui-audit, ui-map, and third-party skills (if installed in current phase). If not visible, the agent isn't reading project-level `.agents/skills/`; copy skill folders to `~/.agents/skills/` as fallback.

## 6. Phase Commands Reference
After interview approves a plan, the agent will guide you through phases. You can also run phase scripts manually:

```bash
# New App workflow
./scripts/phase-new-app.sh 1   # setup
./scripts/phase-new-app.sh 3   # install third-party (core)
./scripts/phase-new-app.sh 5   # ui audit
# ... phases 4,6,7,8,9 run via agent skills

# New Feature workflow
./scripts/phase-new-feature.sh 1  # map sync
# phases 2-5 via agent skills

# Edit/Fix workflow
./scripts/phase-edit-fix.sh 1     # map sync
# phases 2-4 via agent skills

# UI Work workflow
./scripts/phase-ui-work.sh 1      # ui audit
# phases 2-4 via agent skills
```

## 7. Key Files
- `AGENTS.md` — Rules (read every session)
- `third-party.manifest` — Pinned third-party skills (core + optional style)
- `scripts/start.sh` — Entry point (run this first)
- `docs/TRYOUT.md` — Validation suite
- `map/` — Code maps (single shared)
- `map/ui/` — UI maps (single shared)