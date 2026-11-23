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

### Provider options
- **OpenCode**: Uses `opencode.json` with OpenAI-compatible provider. Set `OPENAI_API_KEY` and `OPENAI_BASE_URL` in `.env`.
- **Goose**: Configure provider in Goose settings (OpenAI-compatible, Anthropic, etc.). `.goosehints` symlink to `AGENTS.md` is created by `setup.sh`.
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
- `.goosehints` is created by `setup.sh` as a symlink to `AGENTS.md`.
- Connect your preferred provider (OpenAI-compatible, Anthropic, etc.) via Goose settings.
- Extensions: enable **Developer** and **Summon** (for skills). Add web search and Context7 via extension directory. Keep total active tools under 25.

## 4. Verify Skills Load (Test A)
In a new session, send:
```
List the skills you can see (names only). Do not read any project files.
```
Must show: codebase-map, feature-spec, ui-migration, definition-of-done, design-system, ui-audit, ui-map, and third-party skills installed. If not visible, the agent isn't reading project-level `.agents/skills/`; copy skill folders to `~/.agents/skills/` as fallback.