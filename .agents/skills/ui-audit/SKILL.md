---
name: ui-audit
description: Audit the existing UI (Vue + SCSS) without AI: count colors, spacing, radii, shadows, fonts, animations, duplicated components. Output to docs/ui-audit.txt for human review. Use before filling design-system tokens.
---
# ui-audit

No AI. Pure `rg` analysis. Run once per project (or after major UI changes).

## Prerequisites
- `ripgrep` (rg)
- Source at `apps/app/src` (adjust in script)

## Run
```bash
./scripts/ui-audit.sh [path]
```
Default path: `apps/app/src`

## Output: docs/ui-audit.txt
Sections:
1. **Hex colors** — top 60, deduplicated
2. **rgb/rgba/hsl** — top 40
3. **font-size** — top 30
4. **font-family** — top 15
5. **border-radius** — top 30
6. **box-shadow** — top 30
7. **transition** — top 30
8. **animation** — top 30
9. **padding/margin/gap** — top 40
10. **!important count** — total
11. **:deep() / ::v-deep / >>> count** — total
12. **Component candidates** — `.vue` files in `src/components/` with usage count

## Next step
Paste `docs/ui-audit.txt` to your design chat. Decide:
- Token scale (color steps, space scale, type scale, radius scale, shadow scale, motion tokens)
- Shared component list (BaseButton, BaseInput, BaseSelect, BaseModal, BaseTabs, BaseCard, BaseTable)
- Motion signature (easing, durations, enter/exit style)

Then fill `.agents/skills/design-system/SKILL.md` tokens/components.