---
name: design-system
description: Tokens and rules for any UI work in Vue + SCSS (components, styles, animation, tables, forms). Use before creating or changing any UI so styles come from tokens and shared components, never from hard-coded values.
---
# design-system

STATUS: SKELETON  (change to FILLED after the audit and decisions below are done)

If STATUS is SKELETON: do NOT invent values. Report which tokens or components are missing and ask the user. Suggest running `scripts/style-audit.sh` to collect the values currently used.

## Rules (always apply)
- Styles come from tokens (CSS variables). Never hard-code colors, spacing, font sizes, radii, shadows, durations or easing.
- SCSS: `@use`, never `@import`. SCSS is for breakpoints, mixins and functions; runtime values are CSS variables.
- Shared components live in `src/components/ui/` (adjust). Do not modify them unless the task says so.
- Component styles: `<style lang="scss" scoped>`. No global CSS, no `!important`, no `:deep()` unless the task allows it.
- Do not invent animation styles. Use the motion tokens and mixins below. Respect `prefers-reduced-motion`.
- Every component covers: default, hover, focus (visible), disabled, error, empty, loading.

## Tokens (fill after the audit)
| Group | Token names | Values |
|---|---|---|
| Color | `--color-bg`, `--color-surface`, `--color-text`, `--color-accent`, `--color-border`, ... | TODO |
| Space | `--space-1` ... `--space-8` | TODO |
| Type | `--font-size-sm/md/lg`, `--font-weight-*`, `--line-height-*` | TODO |
| Radius | `--radius-sm/md/lg` | TODO |
| Shadow | `--shadow-1/2/3` | TODO |
| Motion | `--duration-fast/base/slow`, `--ease-standard`, `--ease-emphasis` | TODO |

## Shared components (fill)
BaseButton, BaseInput, BaseSelect, BaseModal, BaseTabs, BaseCard, BaseTable - for each: props, states, where it lives.

## Motion signature (fill)
The division's easing, durations, enter/exit style. This is what makes the UI recognizably ours.

## File locations (fill)
tokens: `src/styles/tokens/`  |  mixins: `src/styles/mixins/`  |  components: `src/components/ui/`
