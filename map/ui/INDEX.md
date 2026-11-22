# UI Map INDEX
Status: SKELETON (run ui-audit, fill design-system, then run ui-map init)

## Tokens (from design-system)
| Group | Token names | Source file |
|---|---|---|
| Color | --color-bg, --color-surface, --color-text, --color-accent, --color-border | TODO |
| Space | --space-1 … --space-8 | TODO |
| Type | --font-size-*, --font-weight-*, --line-height-* | TODO |
| Radius | --radius-sm, --radius-md, --radius-lg | TODO |
| Shadow | --shadow-1, --shadow-2, --shadow-3 | TODO |
| Motion | --duration-fast/base/slow, --ease-standard, --ease-emphasis | TODO |

## Shared components (src/components/ui/)
| Component | File | Props (key) | States covered |
|---|---|---|---|
| BaseButton | BaseButton.vue | variant, size, loading, disabled | default, hover, focus, disabled, loading |
| BaseInput | BaseInput.vue | modelValue, type, error, placeholder | default, focus, error, disabled |
| BaseSelect | BaseSelect.vue | modelValue, options, label, error | default, focus, error, disabled |
| BaseModal | BaseModal.vue | modelValue, title, size | default, open, close, focus-trap |
| BaseTabs | BaseTabs.vue | modelValue, tabs | default, active, disabled |
| BaseCard | BaseCard.vue | variant, padding | default, hover |
| BaseTable | BaseTable.vue | columns, data, sortable | default, loading, empty, sorted |

## Screens (mapped)
| Screen | File | Shared components used | Tokens used | Anomalies | Mapped? |
|---|---|---|---|---|---|
| (screen) | src/views/*.vue | (list) | (list) | (hardcoded values) | no |

## Patterns (mapped)
| Pattern | Screens using it | Key tokens/components | Anomalies | Mapped? |
|---|---|---|---|---|
| Form | (list) | BaseInput, BaseSelect, space, radius | (inconsistencies) | no |
| Table | (list) | BaseTable, type, color | (issues) | no |
| Modal | (list) | BaseModal, motion, shadow | (issues) | no |
| Navigation | (list) | BaseTabs, color, motion | (issues) | no |

## Verified commit
| App | Folder | Branch | Commit | Date | Verified by |
|---|---|---|---|---|---|
| app | apps/app | - | - | - | - |

## Not read / unverified
- (list)