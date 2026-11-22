---
name: feature-spec
description: Turn a requested feature or change into a written spec with impact analysis and small ordered tasks BEFORE any code is written. Use when the user wants to add or redesign a feature, or asks for a spec, plan or impact analysis.
---
# feature-spec

No code in this skill. Output is one file: `docs/features/<slug>.md`, from `docs/features/_TEMPLATE.md`.

## Steps
1. Confirm scope (app + feature). Ask ONE question if unclear.
2. Read the map only: INDEX -> app file -> module files for the affected area. Open source files only to answer a specific question the map cannot.
3. If the skill `grill-with-docs` is installed, run it first to settle requirements and terms. Otherwise ask the user focused questions, one at a time, until flows, failure cases and edge cases are clear. Use `GLOSSARY.md` terms.
4. Write the spec using the template. Be specific: UI behavior names tokens and shared components; data/API names fields and breaking changes.
5. Impact analysis: list modules/files touched, what could break (other screens through shared components, other apps through `map/CROSS-APP.md`), tests to add or update.
6. Acceptance criteria must each be checkable yes/no.
7. Break the work into small ordered tasks. Every task has its own verification step and fits one commit.
8. Record any lasting decision as `docs/adr/NNNN-<slug>.md`.
9. Stop. Ask the user to approve the spec before implementation starts.

## Rules
- Specs are written in full sentences. Do not compress them (style skills do not apply here).
- Do not invent requirements. Unknowns go to "Open questions".
- If a needed map section is missing, run `codebase-map` (deepen) for that module only.
