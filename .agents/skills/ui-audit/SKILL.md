---
name: ui-audit
description: Audit the existing UI (Flutter/Dart) without AI: count colors, spacing, radii, shadows, fonts, animations, duplicated components. Output to docs/ui-audit.txt for human review. Use before filling design-system tokens.
---
# ui-audit

No AI. Pure `rg` analysis. Run once per project (or after major UI changes).

## Prerequisites
- `ripgrep` (rg)
- Source at `apps/app/lib` (adjust in script)

## Run
```bash
./scripts/ui-audit.sh [path]
```
Default path: `apps/app/lib`

## Output: docs/ui-audit.txt
Sections:
1. **Hex colors** — top 60, deduplicated
2. **Color constructors** — `Color(0xFF...)`, top 40
3. **Colors.** — `Colors.blue`, `Colors.red`, etc., top 30
4. **Theme.of** — `Theme.of(context)` usage, top 30
4. **ThemeData** — `ThemeData(` occurrences, top 15
5. **ColorScheme** — `ColorScheme.` usage, top 20
6. **TextStyle** — `TextStyle(` occurrences, top 30
7. **fontSize** — `fontSize:` values, top 30
8. **fontWeight** — `fontWeight:` values, top 15
9. **fontFamily** — `fontFamily:` values, top 15
10. **height** — `height:` (line height), top 15
11. **BorderRadius** — `BorderRadius.` usage, top 30
12. **BoxShadow** — `BoxShadow(` occurrences, top 30
13. **Duration** — `Duration(milliseconds:` values, top 30
14. **Curve** — `Curves.` usage, top 30
15. **padding/margin** — `padding:` / `margin:` values, top 40
16. **EdgeInsets** — `EdgeInsets.` usage, top 30
17. **const usage count** — total (should be high)

## Next step
Paste `docs/ui-audit.txt` to your design chat. Decide:
- Token scale (ColorScheme, spacing scale, TextTheme, BorderRadius scale, BoxShadow scale, motion tokens)
- Shared component list (AppButton, AppInput, AppCard, AppDialog, AppBottomSheet, AppNavigationBar, AppListTile)
- Motion signature (easing, durations, enter/exit style)

Then fill `.agents/skills/design-system/SKILL.md` tokens/components.