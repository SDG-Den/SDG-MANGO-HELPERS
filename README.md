# SDG-MANGO-HELPERS

Helper tools for mangoWM — bar presets, layout switching, config editing, and workspace management.

## Description

SDG-MANGO-HELPERS is a collection of TUI tools for interacting with mangoWM and DMS. It provides system commands and additional internal scripts for workspace management.

## Features

- **dmsbars** — interactive bar preset picker (Classic, Windows, Mac, Combo, Sidebar, Side+Status), toggle individual bars
- **manlayout** — layout switcher (Scroller H/V, Tile L/T/C/R, Grid, Deck, Fair, Monocle, Dwindle)
- **mangoconf** — config file browser and editor (`mangoconf edit`) with bat preview, plus line-by-line viewer (`mangoconf view`) with explanations
- **Workspace swapping** — mark and swap windows between workspaces
- **Config option reference** — covers all mangoWM options
- **Layout button** — bar widget showing current layout

## CLI Usage

```bash
dmsbars                   # Pick bar preset
manlayout                 # Pick layout
mangoconf edit            # Browse and edit mangoWM config files
mangoconf view            # Browse config lines with explanations
```

## Installation

```bash
sdgpkg install sdg-mango-helpers
```

## Dependencies

- `mmsg` — mangoWM IPC
- `mango` — mangoWM compositor
- `dms` — DMS shell
- `fzf`, `bat`, `jq`, `micro`

## Related Packages

- **SDG-MANGO-CORE** — references mangoconf in keybinds
- **SDG-UTIL-SCRIPTS** — shares config editing references
