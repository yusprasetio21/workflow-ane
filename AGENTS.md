# Workspace Rules (read every session)

## 🔴 MANDATORY: Workflow Interview First
**Every new session MUST start with the `workflow-interview` skill.**
- Do NOT run `setup.sh`, `install-third-party.sh`, or any map skill first.
- Do NOT read any project files until the interview completes and user approves the plan.
- First line of your work: `Phase: interview / workflow-interview`

## App (default: one)
| App | Folder | Stack |
|---|---|---|
| app | apps/app | (filled after interview) |

One map for the codebase: `map/INDEX.md`. Default is one app.

## Scope (after interview)
1. User states app and task during interview. If missing, interview asks.
2. First line of work: `Phase: <workflow> / <phase N: Name>`.
3. Read in order: `map/INDEX.md` → `map/apps/<app>.md` → `map/modules/<app>--<module>.md` → only source files the map points to.
4. Never open another app's folder unless cross-app task. Read `map/CROSS-APP.md` first.
5. Never read: node_modules, dist, build, target, .git, lock files, data dumps.
6. Map missing for module? Use `codebase-map` (deepen) for that module only.
7. Map disagrees with code? Trust code, fix map, tell user.
8. If `map/INDEX.md` says `Status: SKELETON`, run `codebase-map` (init) for the app in scope.

## Working Rules
- Smallest change that works. No unrelated edits or refactors.
- Never edit tests to make them pass. Never write secrets into files.
- UI work: follow `design-system` skill. Never hard-code colors, spacing, font sizes, motion.
- UI workflow: audit → tokens → ui-map → migrate per screen. Never invent values.
- Work done only when `definition-of-done` skill satisfied.

## Phase Gates (transparent, user-controlled)
- **Every phase ends with a gate** — user must approve before next phase.
- Agent presents: what will happen, what skills/tools, what output, what to verify.
- User can: approve ("yes"), modify ("change phase 2 to..."), skip ("skip to phase 3"), or abort.
- No autopilot. No hidden installations. No surprise map generation.

## Third-Party Skills (installed on demand, not auto)
- **Core (mattpocock, 7 skills):** Installed in Phase 3 of New App, or Phase 1 of existing app workflows.
- **Style (caveman, ponytail):** ONLY if user explicitly requests in interview. Never auto.
- **Other:** Never without explicit user request.

## Priority When Rules Conflict
1. `definition-of-done`, `design-system`  2. process skills  3. style skills (caveman, ponytail).
Style skills only shorten chat replies and code. Never specs, ADRs, tests, verification, map files.