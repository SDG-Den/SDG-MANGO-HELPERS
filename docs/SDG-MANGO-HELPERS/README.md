# MangoWM Helper Tools

Collection of helper scripts for configuring and interacting with mangoWM and DankMaterial Shell.

## Commands

| Command | Purpose |
|---------|---------|
| `dmsbars` | TUI to toggle bar visibility and apply bar presets |
| `manlayout` | TUI to switch between window layouts |
| `manconf` | Browse and edit mango config files |
| `manmenu` | Interactive config menu with key explainer and docs browser |

## Structure

| Path | Purpose |
|------|---------|
| `SDG-DMS-BARS/bar-presets.sh` | Bar preset picker (dmsbars) |
| `SDG-MANGO-LAYOUTS/layout-switch.sh` | Layout switcher (manlayout) |
| `SDG-MANGO-LAYOUTS/layoutbutton.sh` | Layout indicator for bar widgets |
| `SDG-MANGO-CONF/mango-config.sh` | Config file editor (manconf) |
| `SDG-MANGO-CONF/menu.sh` | Config menu with key explainer (manmenu) |
| `SDG-MANGO-CONF/checker.sh` | Key explainer helper |
| `SDG-MANGO-CONF/browser.sh` | Docs browser helper |
| `SDG-MANGO-CONF/options.list` | Config option reference database |
| `SDG-MANGO-SWAP/marker.sh` | Mark workspace state for swapping |
| `SDG-MANGO-SWAP/swapmarked.sh` | Swap windows between workspaces |

## Dependencies

- `fzf` — interactive selection TUIs
- `bat` — file previews
- `jq` — JSON parsing for mangoWM IPC
- `micro` — default config editor
- `mmsg` — mangoWM message client
- `dms` — DankMaterial Shell control
