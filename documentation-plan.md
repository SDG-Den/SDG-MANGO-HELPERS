# SDG-MANGO-HELPERS Documentation Plan

## Current Status
One doc file exists (`docs/SDG-MANGO-HELPERS/README.md`, full documentation). One local README exists (`local/SDG-MANGO-CONF/README.md`). 4 tip files exist.

## Docs System (`docs/`)
**Deploy location**: `~/.local/docs/SDG-MANGO-HELPERS/`

### Existing Docs
| File | Topic |
|------|-------|
| docs/SDG-MANGO-HELPERS/README.md | Full documentation: all 4 commands, 9 source files, dependencies |
| local/SDG-MANGO-CONF/README.md | Config editor tools: manconf, manmenu, options.list reference |

### Planned Doc Topics
| # | Topic | Description | Priority |
|---|-------|-------------|----------|
| 1 | dmsbars Usage | Bar presets reference, toggling individual bars | High |
| 2 | manlayout Reference | All 14 layouts with descriptions and use cases | High |
| 3 | manconf Walkthrough | Editing mangoWM configs via fzf + bat + micro | Medium |
| 4 | manmenu Deep Dive | Interactive config browser, key explanations, documentation links | Medium |
| 5 | Workspace Swapping | How to use marker.sh and swapmarked.sh workflow | Low |
| 6 | Options List Reference | Structure of options.list and how to extend it | Low |

### Implementation
- Split existing README.md into focused topic files
- Follow SDG-DOCS naming convention

## Tips System (`tips/`)
**Deploy location**: `~/.local/tips/SDG-MANGO-HELPERS/`

### Existing Tips (4)
| File | Topic |
|------|-------|
| bar-presets.md | How to use dmsbars for bar presets |
| config-editor.md | How to use manconf/manmenu |
| layout-switching.md | How to use manlayout |
| workspace-swapping.md | How to use marker/swapmarked |

### Planned Tips
| # | Tip | Description | Priority |
|---|-----|-------------|----------|
| 1 | Quick bar switch | `dmsbars` — quickly switch bar presets | High |
| 2 | Layout picker | `manlayout` — interactive layout selector | High |
| 3 | Config editor | `manconf` — browse and edit mango configs | High |
| 4 | Config explainer | `manmenu` — see explanations for config lines | Medium |
| 5 | Workspace swap | Mark a workspace with marker.sh, then swap with swapmarked.sh | Low |

### Implementation
- Keep existing markdown tip files
- Add a consolidated `tips.list` for SDG-TIPS aggregation
