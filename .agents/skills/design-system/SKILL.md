---
name: design-system
description: Tokens and rules for any UI work in Flutter (Dart). Use before creating or changing any UI so styles come from tokens and shared components, never from hard-coded values.
---
# design-system

STATUS: SKELETON  (change to FILLED after the audit and decisions below are done)

If STATUS is SKELETON: do NOT invent values. Report which tokens or components are missing and ask the user. Suggest running `scripts/ui-audit.sh` to collect the values currently used.

## Rules (always apply)
- Styles come from tokens (ThemeData, ColorScheme, TextTheme). Never hard-code colors, spacing, font sizes, radii, shadows, durations or easing.
- Shared components live in `lib/components/` (adjust). Do not modify them unless the task says so.
- Use Theme.of(context) and ThemeExtensions for custom tokens. No global CSS, no hard-coded values.
- Do not invent animation styles. Use the motion tokens below. Respect `MediaQuery.of(context).disableAnimations`.
- Every component covers: default, hover, focus (visible), disabled, error, empty, loading.

## Tokens (fill after the audit)
| Group | Token names | Values |
|---|---|---|
| Color | ColorScheme (primary, secondary, surface, background, error, onPrimary, onSurface, ...) | TODO |
| Space | spacing scale (e.g., 4, 8, 12, 16, 20, 24, 32, 48) | TODO |
| Type | TextTheme (displayLarge, headlineLarge, titleLarge, bodyLarge, labelLarge, ...) | TODO |
| Radius | BorderRadius values (small, medium, large) | TODO |
| Shadow | BoxShadow values (elevation 1, 2, 3) | TODO |
| Motion | Duration (fast, normal, slow), Curves (standard, emphasized, decelerate) | TODO |

## Shared components (fill)
AppButton, AppInput, AppCard, AppDialog, AppBottomSheet, AppNavigationBar, AppListTile - for each: props, states, where it lives.

## Motion signature (fill)
The division's easing, durations, enter/exit style. This is what makes the UI recognizably ours.

## File locations (fill)
theme: `lib/theme/`  |  tokens: `lib/theme/tokens.dart`  |  components: `lib/components/`