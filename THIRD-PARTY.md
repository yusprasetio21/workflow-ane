# Third-party material

Rules
1. Install only through `scripts/install-third-party.sh` (pins the commit in `third-party.lock`).
2. Read each `.agents/skills/<name>/SKILL.md` before first use. It is an instruction your agent will follow.
3. Check the license. The script keeps each repo's LICENSE file in `LICENSES/`.
4. Never auto-update. Use `--update` deliberately and review the diff.
5. Install ONE process set. Do not combine mattpocock/skills with obra/superpowers (overlapping TDD, debugging, planning).

## Intended sources (core process — installed by default)

| Skills | Repo | License | Role |
|---|---|---|---|
| grilling, grill-with-docs, domain-modeling, to-spec, to-tickets, tdd, setup-matt-pocock-skills | mattpocock/skills | MIT (per repo page) | Process discipline: requirements → spec → tickets → TDD |

## Optional (enable later, measure tokens first)

| Skill | Repo | License | Role |
|---|---|---|---|
| diagnosing-bugs | mattpocock/skills | MIT | Phased debugging |
| prototype | mattpocock/skills | MIT | Multiple UI variants from one route |
| handoff | mattpocock/skills | MIT | Compress conversation to handoff doc |
| writing-for-agents | mattpocock/skills | MIT | Guide to write skills & AGENTS.md |
| ponytail | DietrichGebert/ponytail | verify | Minimal code style |
| caveman | JuliusBrussee/caveman | verify | Short chat replies |

## Own skills (not third-party, edit freely)

| Skill | Purpose |
|---|---|
| codebase-map | Single code map (init/deepen/sync) |
| feature-spec | Feature spec with impact analysis & tasks |
| ui-migration | Migrate one screen to design-system |
| definition-of-done | Completion checklist (lint, test, diff, docs, map) |
| design-system | Tokens, components, motion signature (STATUS: SKELETON) |
| ui-audit | Audit UI values via rg (no AI) → docs/ui-audit.txt |
| ui-map | Single UI design map (tokens, components, screens, patterns) |

## License notes
- mattpocock/skills: MIT (confirmed on repo page)
- ponytail: check https://github.com/DietrichGebert/ponytail/blob/main/LICENSE
- caveman: check https://github.com/JuliusBrussee/caveman/blob/main/LICENSE

Copy each repo's LICENSE to `LICENSES/` when installing.