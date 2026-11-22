---
name: ui-migration
description: Migrate or redesign ONE screen or component to the design system without breaking other screens. Use for any UI change in a Vue + SCSS app when the task names a screen, page or component.
---
# ui-migration

One screen per run, one commit per screen. Read `design-system` first; if its STATUS is SKELETON, stop and report which tokens/components are missing.

## Before changing anything
1. Confirm the screen and the spec (`docs/features/<slug>.md` if it exists).
2. Read the map for that module only. List the files you will touch; include every shared component the screen uses.
3. If a visual test or screenshot tool is available, capture the screen and the screens that share its components BEFORE the change.

## While changing
- Styles only from tokens and shared components. No hard-coded colors, spacing, font sizes, radii, shadows, durations or easing.
- `<style lang="scss" scoped>`; `@use`, never `@import`. No global CSS, no `!important`, no `:deep()` unless the task allows it.
- Do not modify a shared component unless the task says so. If the screen needs it, STOP and report why instead of editing it.
- Cover states: default, hover, focus (visible), disabled, error, empty, loading. Check narrow (375px) and wide (1280px). Respect `prefers-reduced-motion`.
- Touch only the listed files. Report anything else you notice.

## After changing
1. Run the app's lint/test commands (see map/apps/<app>.md). Run visual tests if present and report any OTHER screen that changed.
2. Report: files changed, states covered, shared components untouched (or why not), open issues.
3. Update the module's map file if structure changed. Then apply `definition-of-done`.
