# Screen: app--<screen>
File: `lib/screens/<screen>.dart`  |  Verified commit: <hash>  |  Status: unverified

## Shared components used
- AppButton (variant="primary", size="md")
- AppInput (label="Email", errorText)
- AppDialog (for confirmation)

## Tokens used (per element)
| Element | Color | Space | Radius | Shadow | Motion |
|---|---|---|---|---|---|
| Form card | surface | 6 | lg | elevation 2 | normal |
| Primary button | primary | 3 | md | elevation 1 | fast |
| Error text | error | 1 | - | - | - |

## States covered
- [ ] Default
- [ ] Hover
- [ ] Focus (visible)
- [ ] Disabled
- [ ] Error
- [ ] Empty
- [ ] Loading

## Anomalies (hardcoded / inconsistent)
- `EdgeInsets.all(20)` on line 45 (should use space-5)
- `Colors.blue` on line 12 (should use ColorScheme.primary)
- `Duration(milliseconds: 300)` on line 78 (should use duration-normal)

## Accessibility
- [ ] Labels on all inputs
- [ ] Focus order logical
- [ ] Semantics on dialog
- [ ] Color contrast ≥ 4.5:1

## Not read
- (child components not in shared list)