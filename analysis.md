# SDG-MANGO-HELPERS Analysis

## Type
Desktop Helper Tools Module

## Root Files (not in local/)
- `README.md` — Minimal stub
- `detect.sh` — Dependency checker (verifies mmsg, mango, dms, fzf, bat, jq, micro on PATH)
- `local/SDG-MANGO-CONF/README.md` — Documentation for manconf/manmenu tools

## Description
SDG-MANGO-HELPERS is a collection of Bash shell scripts providing convenient TUI tools for configuring and interacting with mangoWM and DankMaterial Shell. It is the "control panel" for the mangoWM+DMS desktop experience.

## CLI Entry Points
| Command | Symlink | Source Script | Purpose |
|---------|---------|---------------|---------|
| `dmsbars` | `/usr/bin/dmsbars` | `local/SDG-DMS-BARS/bar-presets.sh` | Bar preset picker |
| `manlayout` | `/usr/bin/manlayout` | `local/SDG-MANGO-LAYOUTS/layout-switch.sh` | Layout switcher |
| `manconf` | `/usr/bin/manconf` | `local/SDG-MANGO-CONF/mango-config.sh` | Config file editor |
| `manmenu` | `/usr/bin/manmenu` | `local/SDG-MANGO-CONF/menu.sh` | Interactive config browser |

## Usage
After installation via `sdgpkg install sdg-mango-helpers`, four system commands become available:

### dmsbars — Bar Preset Manager
```bash
dmsbars   # Opens fzf picker of bar presets
```
Shows a menu of bar configurations (Classic, Windows-like, Mac-like, Combo, Sidebar, Side+Status). Select one to apply instantly via `dms ipc call`. You can also toggle individual bars (top bar, taskbar, status bar, left/right sidebar, dock) before applying.

### manlayout — Layout Switcher
```bash
manlayout   # Opens fzf picker of 14 layouts
```
Select from: Scroller (horizontal/vertical), Tile (left/top/center/right), Grid, Deck, Fair, Monocle, Dwindle — each in horizontal/vertical variants. Applies via `mmsg dispatch setlayout,...`.

### manconf — Config File Editor
```bash
manconf   # Browse and edit mangoWM config files
```
Lists all files in `~/.config/mango/` with `bat` previews. Select one to open in `micro` for editing.

### manmenu — Interactive Config Browser
```bash
manmenu   # Browse config lines with explanations
```
Opens a two-pane view: select a config line on the left to see its explanation on the right. Press `Alt+b` to open the config key's documentation URL in Firefox. Covers all mangoWM options (binds, monitors, window rules, animations, scratchpad, etc.).

### Workspace Swapping (via keybinds)
1. Press a key bound to `marker.sh` to mark the current workspace
2. Navigate to another workspace
3. Press a key bound to `swapmarked.sh` to swap all windows between the two workspaces

## Non-Entry-Point Scripts
| Script | Purpose |
|--------|---------|
| `layoutbutton.sh` | Bar widget layout indicator |
| `checker.sh` | Config key explainer (called by menu.sh) |
| `browser.sh` | Open config docs in Firefox (called by menu.sh) |
| `marker.sh` | Mark current workspace for swapping (optional $1 monitor arg) |
| `swapmarked.sh` | Swap windows between workspaces |

## Directory Structure
```
SDG-MANGO-HELPERS/
├── install.sh / update.sh / uninstall.sh
├── detect.sh                      # Dependency checker
├── local/
│   ├── SDG-DMS-BARS/
│   │   └── bar-presets.sh         # Toggle bars / apply presets
│   ├── SDG-MANGO-CONF/
│   │   ├── mango-config.sh        # Config file browser/editor
│   │   ├── menu.sh                # Interactive config line browser
│   │   ├── checker.sh             # Key explainer
│   │   ├── browser.sh             # Docs browser
│   │   └── options.list           # 232 mangoWM config options ref
│   ├── SDG-MANGO-LAYOUTS/
│   │   ├── layout-switch.sh       # Layout switcher (14 layouts)
│   │   ├── layoutbutton.sh        # Bar widget helper
│   │   └── layouts.list           # Layout definitions
│   └── SDG-MANGO-SWAP/
│       ├── marker.sh              # Workspace marker
│       └── swapmarked.sh          # Workspace swapper
├── docs/SDG-MANGO-HELPERS/README.md
└── tips/SDG-MANGO-HELPERS/       # 4 tip files
```

## Bar Presets (dmsbars)
Classic, Windows-like, Mac-like, Combo, Sidebar, Side+Status — each calling `dms ipc call` commands.

## Layout Options (manlayout, 14)
Scroller (horizontal/vertical), Tile (left/top/center/right), Grid, Deck, Fair, Monocle, Dwindle — each in horizontal/vertical variants.

## Config Reference (options.list)
232 pipe-delimited entries covering: input, monitors, visuals/theming, effects (blur, shadows), layouts, overview, bindings (key/mouse/axis/gesture/switch), window rules, tag rules, layer rules, animations, bezier curves.

## Required Dependencies
| Dependency | Provided By | Purpose |
|------------|-------------|---------|
| mmsg | mangoWM / SDG-MANGO-CORE | IPC messaging |
| mango | SDG-MANGO-CORE | Window manager |
| dms | DMS / SDG-DMS-CORE | Shell control |
| fzf | system | Interactive selection |
| bat | system | File previews |
| jq | system | JSON parsing |
| micro | system | Text editor |

## Optional Dependencies
None

## Required Dependents
- **SDG-MANGO-CORE**: References manconf/manmenu in keybinds

## Optional Dependents
- **SDG-UTIL-SCRIPTS**: References mango-config.sh in aliases
