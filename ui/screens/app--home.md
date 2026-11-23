# Screen: app--home
File: `lib/main.dart` (MyHomePage)  |  Verified commit: d11940de  |  Status: unverified

## Shared components used
- (none yet - no shared components exist)

## Tokens used (per element)
| Element | Color | Space | Radius | Shadow | Motion |
|---|---|---|---|---|---|
| Scaffold background | surface (via Theme) | - | - | - | - |
| AppBar background | inversePrimary (via Theme) | - | - | elevation 4 | - |
| AppBar title | onSurface (via Theme) | - | - | - | - |
| Counter text | onSurface (via Theme) | - | - | - | headlineMedium |
| FAB | primary (via Theme) | - | circular | elevation 6 | - |

## States covered
- [ ] Default
- [ ] Hover
- [ ] Focus (visible)
- [ ] Disabled
- [ ] Error
- [ ] Empty
- [ ] Loading

## Anomalies (hardcoded / inconsistent)
- `ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple))` on line ~18 (missing `ColorScheme`, should be `ColorScheme.fromSeed()`)
- `mainAxisAlignment: .center` on line ~65 (missing `MainAxisAlignment`, should be `MainAxisAlignment.center`)
- `Colors.deepPurple` hardcoded as seed color
- `Theme.of(context).colorScheme.inversePrimary` used for AppBar (acceptable but should verify)
- `Theme.of(context).textTheme.headlineMedium` used for counter (acceptable)

## Accessibility
- [ ] Labels on all inputs (N/A - no inputs)
- [ ] Focus order logical
- [ ] Semantics on dialog (N/A - no dialog)
- [ ] Color contrast ≥ 4.5:1 (needs verification with deepPurple seed)

## Not read
- Platform-specific implementations
- test/widget_test.dart