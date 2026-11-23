---
name: workflow-interview
description: MANDATORY first skill in every new session. Conducts structured interview to determine workflow type, then presents phased plan for user approval before any work begins.
---
# workflow-interview

**MUST RUN FIRST in every new session.** No other skill, no setup script, no map reading until this completes.

## Interview Flow (ask ONE question at a time, wait for answer)

### Question 1: Workflow Type
> "What do you want to do?
> 1. **New App** — Create a brand new application from scratch
> 2. **New Feature** — Add a feature to existing app
> 3. **Edit/Fix** — Modify, refactor, or fix existing code
> 4. **UI Work** — Design system, audit, migrate screens
> 5. **Other** — Something else (explain)"

### Question 2: Context (based on answer)

**If 1 (New App):**
> "What stack? (Flutter, Vue+SCSS, Rust, Go, Node, ...)"
> "App name / folder name?"
> "Any existing code to import, or pure greenfield?"

**If 2 (New Feature):**
> "Which app? (folder under apps/)"
> "Feature description in 2-3 sentences?"
> "Any existing spec, or start from scratch?"

**If 3 (Edit/Fix):**
> "Which app? (folder under apps/)"
> "What needs changing? (bug, refactor, update, ...)"
> "Do you have a spec/issue, or explore first?"

**If 4 (UI Work):**
> "Which app?"
> "Audit tokens → decide → map → migrate? Or just migrate one screen?"
> "Design system already filled, or start from audit?"

### Question 3: Confirmation
> "Based on your answers, here's the phased plan. **Reply 'yes' to proceed, or tell me what to change.**"

## Phased Plans (present after Q2, before any work)

### Plan A: New App
| Phase | Name | Skills/Tools | Output | User Gate |
|---|---|---|---|---|
| 1 | **Init Workspace** | `setup.sh` (no third-party yet) | `.env`, `.goosehints`, git hooks | ✅ Confirm |
| 2 | **Interview Stack** | (this skill) | Stack decision, folder structure | ✅ Confirm |
| 3 | **Install Core Skills** | `install-third-party.sh` (mattpocock core only) | 7 process skills in `.agents/skills/` | ✅ Confirm |
| 4 | **Codebase Map Init** | `codebase-map` (init) | `map/INDEX.md`, `map/apps/<app>.md` | ✅ Verify 3 claims |
| 5 | **UI Audit** | `scripts/ui-audit.sh` | `docs/ui-audit.txt` | ✅ Review tokens |
| 6 | **Design System** | `design-system` (fill tokens) | `design-system` STATUS: FILLED | ✅ Approve tokens |
| 7 | **UI Map Init** | `ui-map` (init) | `map/ui/INDEX.md`, screens, patterns | ✅ Verify 3 claims |
| 8 | **Feature Spec** | `feature-spec` (first feature) | `docs/features/<slug>.md` | ✅ Approve spec |
| 9 | **Implement** | `to-spec` → `to-tickets` → `tdd` | Working code, tests, maps updated | ✅ Definition of done |

### Plan B: New Feature (existing app)
| Phase | Name | Skills/Tools | Output | User Gate |
|---|---|---|---|---|
| 1 | **Map Sync** | `check-map-fresh.sh` → `codebase-map` (sync if needed) | Fresh maps | ✅ Confirm |
| 2 | **Grill Requirements** | `grill-with-docs` | Clarified requirements, glossary | ✅ Approve |
| 3 | **Feature Spec** | `feature-spec` | `docs/features/<slug>.md` | ✅ Approve spec |
| 4 | **Break Down** | `to-tickets` | Ordered tasks with verification | ✅ Approve tasks |
| 5 | **Implement** | `tdd` per task | Code, tests, map updates | ✅ Definition of done per task |

### Plan C: Edit/Fix (existing app)
| Phase | Name | Skills/Tools | Output | User Gate |
|---|---|---|---|---|
| 1 | **Map Sync** | `check-map-fresh.sh` → `codebase-map` (sync if needed) | Fresh maps | ✅ Confirm |
| 2 | **Explore/Grill** | `grill-with-docs` or `grilling` | Root cause, scope | ✅ Approve approach |
| 3 | **Plan Fix** | `to-spec` (small) or direct | Fix plan, affected files | ✅ Approve plan |
| 4 | **Implement Fix** | `tdd` or direct | Fix, tests, map updates | ✅ Definition of done |

### Plan D: UI Work
| Phase | Name | Skills/Tools | Output | User Gate |
|---|---|---|---|---|
| 1 | **UI Audit** | `scripts/ui-audit.sh` | `docs/ui-audit.txt` | ✅ Review |
| 2 | **Design System** | `design-system` (fill/verify) | Tokens, components | ✅ Approve |
| 3 | **UI Map** | `ui-map` (init/deepen/sync) | `map/ui/` updated | ✅ Verify claims |
| 4 | **Migrate** | `ui-migration` per screen | Migrated screens | ✅ Visual test |

## Rules
- **Never skip the interview.** If user says "just do X", still run Q1.
- **Present the full plan** before Phase 1. No surprises.
- **Wait for explicit "yes" at each gate.** User can say "skip to phase 3" or "change phase 2".
- **Track phase in session:** First line of every reply: `Phase: <workflow> / <phase N: Name>`.
- **Third-party skills:** Only mattpocock core (7) installed by default. Style skills (caveman/ponytail) only if user explicitly asks in Phase 3.
- **Map skills:** `codebase-map` and `ui-map` run only for the app/module/screen in scope.

## Output Format (after Q2)
```
## Workflow Plan: <New App / New Feature / Edit-Fix / UI Work>

**Context:** <app name, stack, feature description, etc.>

**Phases:**
1. <Phase Name> — <what happens> → Gate: <what user approves>
2. <Phase Name> — <what happens> → Gate: <what user approves>
...

**Third-party skills to install:** mattpocock core (7) / +style (if requested)
**Maps to create/update:** codebase-map (app/module), ui-map (screens/patterns)

**Ready to start Phase 1? Reply 'yes' or request changes.**
```