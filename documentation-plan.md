# SDG-MANGO-HELPERS Documentation Plan

## Current Status
One doc file exists (`docs/SDG-MANGO-HELPERS/README.md`, 36 lines). Four tip files exist in `.md` format. The existing docs cover 4 of the 4 main CLI commands but are brief. Several significant features have zero documentation: RGB Daemon (v1+v2), Window Grouping, layoutbutton.sh, checker.sh category system.

## Source-Verified Inventory
**Components:**

### 4 CLI Commands (symlinked to /usr/bin/)
| Command | Script | Purpose |
|---------|--------|---------|
| dmsbars | `bar-presets.sh` | Interactive bar preset picker (6 presets) + individual bar toggles |
| manlayout | `layout-switch.sh` | Layout switcher (14 layouts via mmsg) |
| manconf | `mango-config.sh` | Config file browser with bat preview + micro editor |
| manmenu | `menu.sh` | Interactive config line browser with key explanations + Firefox docs |

### Additional Scripts (not symlinked)
| Script | Purpose |
|--------|---------|
| `checker.sh` | Config key explainer — 15 category branches (bind, monitor, dwindle, master, scroller, tearing, env, animations, bezier, windowrules, tagrules, layerrules, scratchpad, overview, autostart) |
| `browser.sh` | Opens doc URL for a config key in Firefox |
| `layoutbutton.sh` | Bar widget layout indicator, executes side effects per layout type |
| `marker.sh` | Marks current workspace state for swapping |
| `swapmarked.sh` | Swaps windows between marked and current workspace (multi-monitor) |
| `group-all.sh` | Groups all windows on monitor (used for Fair layouts) |
| `group-merge.sh` | Merges window into a group by direction |
| `rgb-daemon.sh` | v1 RGB keyboard daemon (ckb-next, watches keymode) |
| `rgb-daemon-v2.sh` | v2 daemon (ckb1 device, watches theme/keymode/tags via inotifywait + mmsg) |

### Data Files
| File | Content |
|------|---------|
| `options.list` | 232 pipe-delimited entries covering ALL mangoWM config options |
| `layouts.list` | 14 layout definitions (name | mmsg command) |
| `template.theme` | RGB daemon theme template with color placeholders |

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-MANGO-HELPERS/`

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | dmsbars Usage | 6 presets, individual bar toggles, DMS IPC integration | High |
| 2 | manlayout Reference | 14 layouts with descriptions, use cases, mmsg commands | High |
| 3 | manconf Walkthrough | fzf + bat + micro config editing workflow | High |
| 4 | manmenu Deep Dive | Two-pane config browser, checker.sh explanations, Alt+b for docs | High |
| 5 | Workspace Swapping | marker.sh + swapmarked.sh workflow, multi-monitor, state files | Medium |
| 6 | Options List Reference | options.list format (5 pipe-delimited fields), how to extend | Medium |
| 7 | RGB Daemon | v1 vs v2, hardware requirements (ckb1/ckb-next), theming, autostart | Medium |
| 8 | Window Grouping | group-all.sh (Fair layouts), group-merge.sh, keybinds | Low |
| 9 | layoutbutton.sh | Bar widget layout indicator, per-layout side effects | Low |

### Existing Content
| File | Notes |
|------|-------|
| `docs/SDG-MANGO-HELPERS/README.md` | 36 lines — list of 4 commands + deps. Covers topics #1-4 at high level |
| `local/SDG-MANGO-CONF/README.md` | 20 lines — manconf/manmenu brief. Absorb into topics #3-4 |
| `analysis.md` | Internal analysis with full directory structure and dep mapping |

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-MANGO-HELPERS/`

### Existing Tips (need conversion to .list format)
| # | Tip | Format | Notes |
|---|-----|--------|-------|
| 1 | Quick bar switch (dmsbars) | `bar-presets.md` | .md format, NOT sdgtip-compatible |
| 2 | Layout picker (manlayout) | `layout-switching.md` | .md format, NOT sdgtip-compatible |
| 3 | Config editor (manconf) | `config-editor.md` | .md format, NOT sdgtip-compatible |
| 4 | Workspace swap (marker/swapmarked) | `workspace-swapping.md` | .md format, NOT sdgtip-compatible |

### Additional Planned Tips
| # | Tip | Priority |
|---|-----|----------|
| 5 | Config explainer (manmenu) | Medium |
| 6 | RGB daemon auto-colors keyboard | Medium |
| 7 | Layout indicator in bar | Low |

## Implementation Notes
- Existing .md tip files must be converted to `tips/SDG-MANGO-HELPERS/tips.list` (one tip per line) for sdgtip compatibility
- The .md tip files can remain as expanded reference, but the .list file is what sdgtip reads at runtime
- RGB daemon and window grouping are entirely undocumented in the current plan — adding them here
- checker.sh has 15 category branches with detailed help — this is a major feature worth documenting in topic #4
