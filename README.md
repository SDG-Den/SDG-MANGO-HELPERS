# SDG-MANGO-HELPERS

Helper tools for mangoWM — bar presets, layout switching, config editing, and workspace management.

## Description

SDG-MANGO-HELPERS is a collection of TUI tools for interacting with mangoWM and DMS. It provides four system commands and additional internal scripts for workspace management.

## Features

- **dmsbars** — interactive bar preset picker (Classic, Windows, Mac, Combo, Sidebar, Side+Status), toggle individual bars
- **manlayout** — 14 layout switcher (Scroller H/V, Tile L/T/C/R, Grid, Deck, Fair, Monocle, Dwindle)
- **manconf** — config file browser with bat preview, opens in micro editor
- **manmenu** — interactive config line explainer with documentation links
- **Workspace swapping** — mark and swap windows between workspaces
- **232-entry config reference** — covers all mangoWM options
- **Layout button** — bar widget showing current layout

## CLI Usage

```bash
dmsbars                   # Pick bar preset
manlayout                 # Pick layout
manconf                   # Browse and edit mangoWM configs
manmenu                   # Browse config with explanations
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

- **SDG-MANGO-CORE** — references manconf/manmenu in keybinds
- **SDG-UTIL-SCRIPTS** — shares config editing references
