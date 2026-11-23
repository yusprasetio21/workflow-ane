# workflow-ane

Personal AI-assisted development template (Indonesian branding: "ane" = me/mine).
Single code map + single UI map. Interview-first, phased, transparent. No autopilot.

## Quick Start

```bash
# 1. Create new project from template
gh repo create myapp --template yusprasetio21/workflow-ane --private --clone
cd myapp

# 2. Read entry point (shows interview instructions)
./scripts/start.sh

# 3. Open NEW agent session here, send:
#    "Run workflow-interview skill. I want to start."

# 4. Agent asks 3 questions → presents phased plan → you approve each gate
```

## Workflow Types

| Type | Use When | Phases |
|---|---|---|
| **New App** | Greenfield project | 9 phases: setup → stack → install core → codebase map → UI audit → design system → UI map → feature spec → implement |
| **New Feature** | Add feature to existing app | 5 phases: map sync → grill requirements → feature spec → break down → implement |
| **Edit/Fix** | Bug fix, refactor, update | 4 phases: map sync → explore/grill → plan fix → implement fix |
| **UI Work** | Design system, audit, migrate | 4 phases: UI audit → design system → UI map → migrate per screen |

## Core Principles

1. **Interview First** — Every session starts with `workflow-interview` skill. No exceptions.
2. **Phased with Gates** — Plan presented upfront. You approve each phase before execution.
3. **Single Maps** — One `map/INDEX.md` for code, one `map/ui/INDEX.md` for UI. Lazy-loaded, scope-enforced.
4. **Token Efficient** — Agents read maps (50 lines) not source (5000 lines). Maps cite file:function.
5. **Core Process Only** — Matt Pocock 7 skills (grilling, grill-with-docs, domain-modeling, to-spec, to-tickets, tdd, setup). Style skills (caveman, ponytail) **opt-in only**.
6. **Agent Agnostic** — Works with Goose, OpenCode, Claude Code. Provider config in `opencode.json` / `.env`.

## Structure

```
.
├── AGENTS.md                 # Rules (read every session)
├── scripts/
│   ├── start.sh              # Entry point — run first
│   ├── setup.sh              # Phase 1: basic workspace
│   ├── install-third-party.sh # Phase 3: mattpocock core (--with-style for caveman/ponytail)
│   ├── phase-*.sh            # Phase runners for each workflow
│   ├── ui-audit.sh           # RG-based UI token extraction
│   ├── style-audit.sh        # RG-based style token extraction
│   └── check-map-fresh.sh    # Map freshness check
├── .agents/skills/           # Custom skills (loaded by agent)
│   ├── workflow-interview/   # MANDATORY first skill
│   ├── codebase-map/         # Code map: init/deepen/sync
│   ├── feature-spec/         # Spec with impact analysis
│   ├── ui-migration/         # Migrate one screen to design system
│   ├── definition-of-done/   # Completion checklist
│   ├── design-system/        # Tokens & shared components
│   ├── ui-audit/             # RG-based audit skill
│   ├── ui-map/               # UI map: init/deepen/sync
│   └── (third-party/)        # Installed on demand
├── map/
│   ├── INDEX.md              # System purpose, apps, verified commits
│   ├── apps/app.md           # App: modules, data flow, risks
│   ├── modules/app--*.md     # Per-module detail
│   ├── ui/
│   │   ├── INDEX.md          # Tokens, components, screens, patterns
│   │   ├── screens/app--*.md # Per-screen detail
│   │   └── patterns/*.md     # Reusable patterns (form, list, dialog, nav)
│   └── CROSS-APP.md          # Cross-app contracts (rare)
├── docs/
│   ├── features/             # Feature specs (from feature-spec)
│   ├── adr/                  # Architecture decisions
│   ├── TRYOUT.md             # Validation suite
│   └── AGENT-SETUP.md        # Provider setup guide
├── third-party.manifest      # Pinned third-party skills
├── third-party.lock          # Pinned commits (auto-generated)
├── opencode.json             # OpenCode provider config
└── .env.example              # API key template
```

## Validation

Run the full suite: `docs/TRYOUT.md`

Key tests:
- **B** Interview & plan presentation (no autopilot)
- **F** Codebase map init (lazy, scoped, verified)
- **H** Design system filled from audit (no invented tokens)
- **I** UI map init (mirrors code map structure)
- **L/M** Scope discipline & map reuse (token efficiency)

## License

MIT — Personal template, use freely.