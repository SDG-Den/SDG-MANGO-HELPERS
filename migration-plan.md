# SDG-MANGO-HELPERS Migration Plan

## Directory Mapping

| Source | Installed to |
|--------|-------------|
| `local/SDG-DMS-BARS/bar-presets.sh` | `~/.local/SDG-DMS-BARS/bar-presets.sh` |
| `local/SDG-MANGO-LAYOUTS/layout-switch.sh` | `~/.local/SDG-MANGO-LAYOUTS/layout-switch.sh` |
| `local/SDG-MANGO-LAYOUTS/layouts.list` | `~/.local/SDG-MANGO-LAYOUTS/layouts.list` |
| `local/SDG-MANGO-LAYOUTS/layoutbutton.sh` | `~/.local/SDG-MANGO-LAYOUTS/layoutbutton.sh` |
| `local/SDG-MANGO-CONF/mango-config.sh` | `~/.local/SDG-MANGO-CONF/mango-config.sh` |
| `local/SDG-MANGO-CONF/menu.sh` | `~/.local/SDG-MANGO-CONF/menu.sh` |
| `local/SDG-MANGO-CONF/checker.sh` | `~/.local/SDG-MANGO-CONF/checker.sh` |
| `local/SDG-MANGO-CONF/browser.sh` | `~/.local/SDG-MANGO-CONF/browser.sh` |
| `local/SDG-MANGO-CONF/options.list` | `~/.local/SDG-MANGO-CONF/options.list` |
| `local/SDG-MANGO-SWAP/marker.sh` | `~/.local/SDG-MANGO-SWAP/marker.sh` |
| `local/SDG-MANGO-SWAP/swapmarked.sh` | `~/.local/SDG-MANGO-SWAP/swapmarked.sh` |
| `tips/` | `~/.local/tips/SDG-MANGO-HELPERS/` |
| `docs/` | `~/.local/docs/SDG-MANGO-HELPERS/` |

## Path Rewrites

### Hardcoded `/home/$(whoami)/` → `$HOME`

- **`menu.sh` line 3**: `CONFDIR="/home/$(whoami)/.config/mango"` → `CONFDIR="$HOME/.config/mango"`
- **`mango-config.sh` line 3**: `CONFDIR="/home/$(whoami)/.config/mango"` → `CONFDIR="$HOME/.config/mango"`

### Internal references (`~/.config/sdgos/config-overview/` → `~/.local/SDG-MANGO-CONF/`)

- **`checker.sh` lines 11-14**: `~/.config/sdgos/config-overview/options.list` → `~/.local/SDG-MANGO-CONF/options.list`
- **`browser.sh` line 10**: `~/.config/sdgos/config-overview/options.list` → `~/.local/SDG-MANGO-CONF/options.list`
- **`menu.sh` line 13**: `~/.config/sdgos/config-overview/browser.sh` → `~/.local/SDG-MANGO-CONF/browser.sh`
- **`menu.sh` line 13**: `~/.config/sdgos/config-overview/checker.sh` → `~/.local/SDG-MANGO-CONF/checker.sh`

### Internal references (`~/.config/sdgos/tuis/` → `~/.local/SDG-MANGO-LAYOUTS/`)

- **`layout-switch.sh` lines 6, 8**: `~/.config/sdgos/tuis/layouts.list` → `~/.local/SDG-MANGO-LAYOUTS/layouts.list`

## Lifecycle Scripts

All four root-level scripts are empty. Implement:

- **install.sh**: Copy each `local/SDG-*/` directory to `~/.local/`, copy docs/tips.
- **uninstall.sh**: Remove `~/.local/SDG-*-BARS/`, `~/.local/SDG-MANGO-*/`, docs/tips.
- **update.sh**: Re-deploy.
- **detect.sh**: Check `mmsg`, `mango`, `dms` commands.

## Modular Tips

- Create `tips/` with tips about config viewer/editor, layout switching, workspace swapping, bar presets.

## Modular Docs

- `docs/` is empty — could document the available helper commands (`mangoconf-viewer`, `mangoconf-editor`, etc.)

## Empty Dir Cleanup

| Dir | Action |
|-----|--------|
| `cache/` | Remove |
| `tips/` | Populate or remove |
| `other/` | Remove |
| `docs/` | Populate or remove |
