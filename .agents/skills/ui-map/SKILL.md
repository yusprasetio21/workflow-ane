---
name: ui-map
description: Create and maintain a UI design map (tokens, components, screens, patterns) under map/ui/. Modes: init, deepen, sync. Read once, reuse many. Mirrors codebase-map but for design decisions.
---
# ui-map

Goal: map every design decision so agents read the map (50 lines) instead of source files (500 lines).

## Ground rules
- ONE UI map for the app. Lives in `map/ui/`.
- Every claim cites a file path and component/token name.
- Never copy styles into the map. Point to them.
- Record what you did NOT read ("Not read" sections).
- Mark new sections `unverified` until human confirms.
- Size limits: INDEX ≤ 80 lines, screen file ≤ 100, pattern file ≤ 80.
- Ignore: node_modules, dist, build, .git, lock files, generated files.

## Structure
```
map/ui/
├── INDEX.md          # Tokens, shared components, global patterns, verified commit
├── screens/          # Per screen: app--<screen>.md
│   ├── app--home.md
│   └── ...
└── patterns/         # Reusable patterns
    ├── form.md
    ├── list.md
    ├── dialog.md
    └── navigation.md
```

## Mode: init (first run, or INDEX.md missing)
1. Read `docs/ui-audit.txt` (if exists) and `.agents/skills/design-system/SKILL.md` (tokens/components).
2. Scan `apps/app/lib` for:
   - All `.dart` files in `lib/screens/`, `lib/pages/`, `lib/views/` → these are screens
   - All `.dart` files in `lib/components/` → shared components
   - All `.dart` in `lib/theme/`, `lib/theme/tokens.dart`
3. Create `map/ui/INDEX.md` from template below.
4. Create `map/ui/screens/app--<screen>.md` for each screen (skeleton only: file path, shared components used, tokens used, anomalies).
5. Create `map/ui/patterns/*.md` for each recurring pattern (form, list, dialog, navigation).
6. Record verified commit: `git -C apps/app rev-parse HEAD`.
7. Set `Status: INITIALIZED (unverified)`.

## Mode: deepen (one screen or pattern)
1. Read the screen/pattern file, then only the source files it points to.
2. Fill details: exact tokens per state, component props, animation variants, accessibility gaps.
3. Update `map/ui/INDEX.md` if new token/component discovered.

## Mode: sync (code changed)
1. Read recorded commit from `map/ui/INDEX.md`. List changes: `git -C apps/app diff --name-only <commit>..HEAD -- '*.dart'`.
2. Keep only paths under mapped screens/patterns. Re-read only those files.
3. Update affected screen/pattern files and INDEX. Leave rest untouched.
4. Update commit in INDEX. List what changed.
5. Commit not found? Say so, mark affected sections unverified.

## Templates

### map/ui/INDEX.md
```markdown
# UI Map INDEX
Status: INITIALIZED (unverified)  |  Verified commit: <hash> (<date>)

## Tokens (from design-system)
| Group | Token names | Source file |
|---|---|---|
| Color | ColorScheme (primary, secondary, surface, background, error, ...) | lib/theme/tokens.dart |
| Space | spacing scale (4, 8, 12, 16, 20, 24, 32, 48) | lib/theme/tokens.dart |
| Type | TextTheme (displayLarge, headlineLarge, titleLarge, bodyLarge, labelLarge, ...) | lib/theme/tokens.dart |
| Radius | BorderRadius (small, medium, large) | lib/theme/tokens.dart |
| Shadow | BoxShadow (elevation 1, 2, 3) | lib/theme/tokens.dart |
| Motion | Duration (fast, normal, slow), Curves (standard, emphasized, decelerate) | lib/theme/tokens.dart |

## Shared components (lib/components/)
| Component | File | Props (key) | States covered |
|---|---|---|---|
| AppButton | app_button.dart | variant, size, loading, disabled, onPressed | default, hover, focus, disabled, loading |
| AppInput | app_input.dart | controller, label, error, hint, obscureText | default, focus, error, disabled |
| ... | | | |

## Screens (mapped)
| Screen | File | Shared components used | Tokens used | Anomalies | Mapped? |
|---|---|---|---|---|---|
| Home | lib/screens/home.dart | AppButton, AppInput | color, space, type | hardcoded Colors.blue | yes |
| Settings | lib/screens/settings.dart | AppCard, AppListTile | color, space, radius | inline EdgeInsets.all(20) | yes |

## Patterns (mapped)
| Pattern | Screens using it | Key tokens/components | Anomalies | Mapped? |
|---|---|---|---|---|
| Form | Home, Login, Profile | AppInput, AppButton, space, radius | inconsistent error placement | yes |
| List | Home, Settings, Reports | AppListTile, type, color | no separator consistency | yes |
| Dialog | ConfirmDelete, UserDetail | AppDialog, motion, shadow | no focus trap | yes |
| Navigation | Layout, BottomNav | NavigationBar, color, motion | active state hardcoded | yes |

## Not read / unverified
- (list)
```

### map/ui/screens/app--<screen>.md
```markdown
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
- `Duration(milliseconds: 300)` on line 78 (should use duration-base)

## Accessibility
- [ ] Labels on all inputs
- [ ] Focus order logical
- [ ] Semantics on dialog
- [ ] Color contrast ≥ 4.5:1

## Not read
- (child components not in shared list)
```

### map/ui/patterns/<pattern>.md
```markdown
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
```

## Finish every run with
- Files created/changed in `map/ui/`.
- The "Not read" list.
- 2-5 specific claims the user should check against the code.