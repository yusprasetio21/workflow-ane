# Workspace rules (read every session)

## App (default: one)
| App | Folder | Stack |
|---|---|---|
| app | apps/app | (fill in: e.g., Vue + SCSS, Rust, Go, ...) |

One map for the codebase: `map/INDEX.md`. If you work with multiple source folders, list them here and in `map/INDEX.md` — but **default is one app**. Only add more when the user explicitly asks.

## Scope (most important)
1. The user states the app and task at session start. If missing or ambiguous, ask ONE question. Never "read everything" to find out.
2. First line of your work: `Scope: <app> / <module or task>`.
3. Read in this order and stop as soon as you can act: `map/INDEX.md` -> `map/apps/<app>.md` -> `map/modules/<app>--<module>.md` -> only the source files the map points to.
4. Never open another app's folder unless the task is cross-app. Then read `map/CROSS-APP.md` first and say why.
5. Never read: node_modules, dist, build, target, .git, lock files, data dumps.
6. Map missing for a module? Use the `codebase-map` skill (deepen) for that module only.
7. Map disagrees with code? Trust the code, fix the map, tell the user.
8. If `map/INDEX.md` says `Status: SKELETON`, run `codebase-map` (init) for the app in scope before anything else.

## Working rules
- Smallest change that works. No unrelated edits or refactors.
- Never edit tests to make them pass. Never write secrets into files.
- UI work: follow the `design-system` skill. Never hard-code colors, spacing, font sizes or motion values.
- UI workflow: audit → tokens → ui-map → migrate per screen. Never invent values.
- Work is done only when the `definition-of-done` skill is satisfied.

## Priority when rules conflict
1. definition-of-done, design-system  2. process skills  3. style skills (caveman, ponytail).
Style skills only shorten chat replies and code. They never shorten specs, ADRs, tests, verification steps or map files.
