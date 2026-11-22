# Screen: app--<screen>
File: `src/views/<Screen>.vue`  |  Verified commit: <hash>  |  Status: unverified

## Shared components used
- BaseButton (variant="primary", size="md")
- BaseInput (type="email", error prop)
- BaseModal (for forgot password)

## Tokens used (per element)
| Element | Color | Space | Radius | Shadow | Motion |
|---|---|---|---|---|---|
| Form card | --color-surface | --space-6 | --radius-lg | --shadow-2 | --duration-base |
| Primary button | --color-accent | --space-3 | --radius-md | --shadow-1 | --duration-fast |
| Error text | --color-error | --space-1 | - | - | - |

## States covered
- [ ] Default
- [ ] Hover
- [ ] Focus (visible)
- [ ] Disabled
- [ ] Error
- [ ] Empty
- [ ] Loading

## Anomalies (hardcoded / inconsistent)
- `style="margin-top: 20px"` on line 45 (should use --space-5)
- `#3B82F6` on line 12 (should use --color-accent)
- `transition: all 0.3s` on line 78 (should use --duration-base + --ease-standard)

## Accessibility
- [ ] Labels on all inputs
- [ ] Focus order logical
- [ ] ARIA on modal
- [ ] Color contrast ≥ 4.5:1

## Not read
- (child components not in shared list)