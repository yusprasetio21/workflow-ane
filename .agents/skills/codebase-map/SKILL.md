---
name: codebase-map
description: Create and maintain the single shared map of the apps in apps/ under map/. Use when map/INDEX.md has Status SKELETON, when a module has no map file yet, or after code changes that touch a mapped module. Modes - init, deepen, sync.
---
# codebase-map

Goal: read each part of the code once, record it in `map/`, and let later sessions read the map instead of the code.

## Ground rules
- ONE map for all apps. Do not create per-app maps unless the user asks.
- Stay inside the scope the user gave. Map only what the task needs.
- Every claim cites a file path and a function/class/route name. No citation, no claim.
- Never copy code into the map. Point to it.
- Always record what you did NOT read ("Not read" sections).
- Mark every new section `unverified` until a human confirms it.
- Size limits: INDEX <= 60 lines, app file <= 150, module file <= 100. Split instead of growing.
- Ignore: node_modules, dist, build, target, .git, lock files, data dumps.
- Use cheap structure first (tree depth 2, manifests, route files, entry points). If a code-analysis tool is available, use it before reading raw files.

## Mode: init (INDEX is SKELETON)
1. For each app in scope: list the top-level tree (depth 2); read the manifest (package.json, Cargo.toml, pom.xml, ...), entry points, router/route definitions, README.
2. Fill `map/INDEX.md`: system purpose, one line per app, stack, entry points, how to run/test, module names only.
3. Create `map/apps/<app>.md` from `map/apps/_TEMPLATE.md` (module list, main data flow, risky areas). Do not read module internals yet.
4. Record in the INDEX "Verified commits" row: `git -C apps/<app> rev-parse HEAD`, branch, date.
5. Set `Status: INITIALIZED (unverified)`.

## Mode: deepen (one module)
1. Read the app file, then only the files of that module.
2. Create `map/modules/<app>--<module>.md` from `map/modules/_TEMPLATE.md`.
3. Contracts with other apps (endpoints, payloads, shared tables, report inputs) go to `map/CROSS-APP.md`.
4. Update the module/app commit in INDEX; mark the module as mapped in the app file.

## Mode: sync (code changed)
1. Read the app's recorded commit from INDEX. List changes: `git -C apps/<app> diff --name-only <commit>..HEAD`.
2. Keep only paths that belong to mapped modules. Re-read only those files.
3. Update the affected module/app sections, and CROSS-APP if a contract changed. Leave the rest untouched.
4. Update the commit in INDEX. List what changed in your reply.
5. Commit not found (history rewritten)? Say so and mark the module unverified.

(The user can run `scripts/check-map-fresh.sh` to see which apps moved since their recorded commit.)

## Finish every run with
- Files created/changed in `map/`.
- The "Not read" list.
- 2-5 specific claims the user should check against the code.
