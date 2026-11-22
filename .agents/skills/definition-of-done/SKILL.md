---
name: definition-of-done
description: Checklist that must be satisfied before any task is reported as finished (code, UI or docs). Use at the end of every implementation task and before committing.
---
# definition-of-done

Use the test/lint commands in `map/apps/<app>.md` ("How to run/test"). If none are recorded, ask the user. Do not guess commands.

## Checklist (report each item as done / not applicable / blocked)
- [ ] Acceptance criteria of the spec or task are met (list each).
- [ ] Tests added or updated for new behavior and failure cases; all tests pass. Tests were NOT edited just to pass.
- [ ] Lint/format/type checks pass with no new warnings.
- [ ] You re-read your own diff; no unrelated changes, no leftover debug code, no secrets.
- [ ] UI work: `design-system` rules followed; no other screen affected (or listed).
- [ ] Map updated for every touched module, and the verified commit in `map/INDEX.md` refreshed.
- [ ] Docs updated: spec status, ADR if a lasting decision was made, `GLOSSARY.md` if a term changed.

## Final report (plain language, not compressed)
1. What changed and why (3-6 lines).
2. How it was verified (commands run and results).
3. Risks or open questions.
4. Files touched.
