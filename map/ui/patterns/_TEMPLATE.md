# Pattern: <pattern> (e.g., form, table, modal, navigation)
Screens: app--login, app--register, app--profile  |  Verified commit: <hash>  |  Status: unverified

## Structure
(shared component composition, slot usage, prop drilling)

## Tokens (standardized across screens)
| Purpose | Token | Fallback if missing |
|---|---|---|
| Container padding | --space-6 | 24px |
| Field gap | --space-4 | 16px |
| Label size | --font-size-sm | 14px |
| Input radius | --radius-md | 6px |
| Error color | --color-error | #DC2626 |
| Focus ring | --color-accent + --shadow-focus | ring-2 ring-blue-500 |

## Component API (shared)
- BaseInput: modelValue, label, error, hint, type, placeholder, disabled, required
- BaseSelect: modelValue, options, label, error, placeholder, disabled
- BaseButton: variant, size, loading, disabled, icon, iconPosition

## Anomalies per screen
- Login: error message below input (correct)
- Register: error message inline (inconsistent)
- Profile: no error state implemented

## Motion
- Enter: fade-in + slide-up (--duration-base, --ease-emphasis)
- Exit: fade-out (--duration-fast, --ease-standard)
- Respects prefers-reduced-motion: yes/no

## Not read
- (edge cases not yet checked)