# Pattern: <pattern> (e.g., form, list, dialog, navigation)
Screens: app--home, app--login, app--profile  |  Verified commit: <hash>  |  Status: unverified

## Structure
(shared component composition, slot usage, prop drilling)

## Tokens (standardized across screens)
| Purpose | Token | Fallback if missing |
|---|---|---|
| Container padding | space-6 | 24px |
| Field gap | space-4 | 16px |
| Label size | labelLarge | 14px |
| Input radius | radius-md | 6px |
| Error color | error | #DC2626 |
| Focus ring | primary + shadow-focus | - |

## Component API (shared)
- AppInput: controller, label, errorText, hintText, obscureText, enabled
- AppButton: variant, size, loading, disabled, onPressed, icon
- AppDialog: title, content, actions, barrierDismissible

## Anomalies per screen
- Home: error message below input (correct)
- Login: error message inline (inconsistent)
- Profile: no error state implemented

## Motion
- Enter: fade-in + slide-up (duration-normal, curve-emphasized)
- Exit: fade-out (duration-fast, curve-standard)
- Respects disableAnimations: yes/no

## Not read
- (edge cases not yet checked)