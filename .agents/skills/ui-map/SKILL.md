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
- Ignore: node_modules, dist, build, .git, lock files, generated CSS.

## Structure
```
map/ui/
├── INDEX.md          # Tokens, shared components, global patterns, verified commit
├── screens/          # Per screen: app--<screen>.md
│   ├── app--login.md
│   ├── app--dashboard.md
│   └── ...
└── patterns/         # Reusable patterns
    ├── form.md
    ├── table.md
    ├── modal.md
    └── navigation.md
```

## Mode: init (first run, or INDEX.md missing)
1. Read `docs/ui-audit.txt` (if exists) and `.agents/skills/design-system/SKILL.md` (tokens/components).
2. Scan `apps/app/src` for:
   - All `.vue` files in `src/views/`, `src/pages/`, `src/layouts/` → these are screens
   - All `.vue` files in `src/components/ui/` → shared components
   - All `.scss` in `src/styles/tokens/`, `src/styles/mixins/`
3. Create `map/ui/INDEX.md` from template below.
4. Create `map/ui/screens/app--<screen>.md` for each screen (skeleton only: file path, shared components used, tokens used, anomalies).
5. Create `map/ui/patterns/*.md` for each recurring pattern (form, table, modal, navigation).
6. Record verified commit: `git -C apps/app rev-parse HEAD`.
7. Set `Status: INITIALIZED (unverified)`.

## Mode: deepen (one screen or pattern)
1. Read the screen/pattern file, then only the source files it points to.
2. Fill details: exact tokens per state, component props, animation variants, accessibility gaps.
3. Update `map/ui/INDEX.md` if new token/component discovered.

## Mode: sync (code changed)
1. Read recorded commit from `map/ui/INDEX.md`. List changes: `git -C apps/app diff --name-only <commit>..HEAD -- '*.vue' '*.scss'`.
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
| Color | --color-bg, --color-surface, --color-text, --color-accent, --color-border | src/styles/tokens/color.scss |
| Space | --space-1 … --space-8 | src/styles/tokens/space.scss |
| Type | --font-size-*, --font-weight-*, --line-height-* | src/styles/tokens/type.scss |
| Radius | --radius-sm, --radius-md, --radius-lg | src/styles/tokens/radius.scss |
| Shadow | --shadow-1, --shadow-2, --shadow-3 | src/styles/tokens/shadow.scss |
| Motion | --duration-fast/base/slow, --ease-standard, --ease-emphasis | src/styles/tokens/motion.scss |

## Shared components (src/components/ui/)
| Component | File | Props (key) | States covered |
|---|---|---|---|
| BaseButton | BaseButton.vue | variant, size, loading, disabled | default, hover, focus, disabled, loading |
| BaseInput | BaseInput.vue | modelValue, type, error, placeholder | default, focus, error, disabled |
| ... | | | |

## Screens (mapped)
| Screen | File | Shared components used | Tokens used | Anomalies | Mapped? |
|---|---|---|---|---|---|
| Login | src/views/Login.vue | BaseButton, BaseInput | color, space, radius | hardcoded #3B82F6 | yes |
| Dashboard | src/views/Dashboard.vue | BaseCard, BaseTable | color, space, type | inline style margin-top: 20px | yes |

## Patterns (mapped)
| Pattern | Screens using it | Key tokens/components | Anomalies | Mapped? |
|---|---|---|---|---|
| Form | Login, Register, Profile | BaseInput, BaseSelect, space, radius | inconsistent error placement | yes |
| Table | Dashboard, Reports | BaseTable, type, color | fixed header not sticky | yes |
| Modal | ConfirmDelete, UserDetail | BaseModal, motion, shadow | no focus trap | yes |
| Navigation | Layout, Sidebar | BaseTabs, color, motion | active state hardcoded | yes |

## Not read / unverified
- (list)
```

### map/ui/screens/app--<screen>.md
```markdown
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
```

### map/ui/patterns/<pattern>.md
```markdown
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
```

## Finish every run with
- Files created/changed in `map/ui/`.
- The "Not read" list.
- 2-5 specific claims the user should check against the code.