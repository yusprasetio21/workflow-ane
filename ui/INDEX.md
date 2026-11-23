# UI Map INDEX
Status: INITIALIZED (unverified)  |  Verified commit: d11940de (2026-11-23)

## Tokens (from design-system)
| Group | Token names | Source file |
|---|---|---|
| Color | ColorScheme (primary, secondary, surface, background, error, onPrimary, onSurface, ...) | lib/theme/tokens.dart |
| Space | spacing scale (4, 8, 12, 16, 20, 24, 32, 48) | lib/theme/tokens.dart |
| Type | TextTheme (displayLarge, headlineLarge, titleLarge, bodyLarge, labelLarge, ...) | lib/theme/tokens.dart |
| Radius | BorderRadius (small, medium, large) | lib/theme/tokens.dart |
| Shadow | BoxShadow (elevation 1, 2, 3) | lib/theme/tokens.dart |
| Motion | Duration (fast, normal, slow), Curves (standard, emphasized, decelerate) | lib/theme/tokens.dart |

## Shared components (lib/components/)
| Component | File | Props (key) | States covered |
|---|---|---|---|
| AppButton | app_button.dart | variant, size, loading, disabled, onPressed | default, hover, focus, disabled, loading |
| AppInput | app_input.dart | controller, label, errorText, hintText, obscureText | default, focus, error, disabled |
| AppCard | app_card.dart | variant, padding | default, hover |
| AppDialog | app_dialog.dart | title, content, actions, barrierDismissible | default, open, close, focus-trap |
| AppBottomSheet | app_bottom_sheet.dart | builder, isScrollControlled | default, open, close |
| AppNavigationBar | app_navigation_bar.dart | currentIndex, destinations, onDestinationSelected | default, selected, disabled |
| AppListTile | app_list_tile.dart | leading, title, subtitle, trailing, onTap | default, selected, disabled, hover |

## Screens (mapped)
| Screen | File | Shared components used | Tokens used | Anomalies | Mapped? |
|---|---|---|---|---|---|
| Home | lib/main.dart (MyHomePage) | (none yet) | color, space, type | hardcoded Colors.deepPurple, .center syntax, Theme.of context.colorScheme.inversePrimary | no |

## Patterns (mapped)
| Pattern | Screens using it | Key tokens/components | Anomalies | Mapped? |
|---|---|---|---|---|
| Form | (list) | AppInput, AppButton, space, radius | (inconsistencies) | no |
| List | (list) | AppListTile, type, color | (issues) | no |
| Dialog | (list) | AppDialog, motion, shadow | (issues) | no |
| Navigation | (list) | AppNavigationBar, color, motion | (issues) | no |

## Verified commit
| App | Folder | Branch | Commit | Date | Verified by |
|---|---|---|---|---|---|
| app | apps/app | main | d11940de | 2026-11-23 | ui-map init |

## Not read / unverified
- lib/main.dart internals (MyHomePageState, _incrementCounter)
- test/widget_test.dart
- Platform-specific folders not analyzed
- design-system tokens not yet filled (STATUS: SKELETON)