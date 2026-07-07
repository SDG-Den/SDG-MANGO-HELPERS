# SDG-MANGO-HELPERS Migration Plan

## 1. Implement Lifecycle Scripts

All four root-level lifecycle scripts are **empty stubs** — must be implemented:

| Script | Purpose |
|--------|---------|
| `install.sh` | Deploy scripts from `local/SDG-*/` to `~/.config/sdgos/` |
| `uninstall.sh` | Remove all deployed scripts and configs |
| `update.sh` | Overwrite scripts (preserve state files) |
| `detect.sh` | Check for `mmsg`, `mango`, `dms` commands |

## 2. Path Audit — Hardcoded `/home/$(whoami)/`

### 2.1 `local/SDG-MANGO-CONF/menu.sh` — line 3
```bash
CONFDIR="/home/$(whoami)/.config/mango"
```
- Change to `CONFDIR="$HOME/.config/mango"`.

### 2.2 `local/SDG-MANGO-CONF/mango-config.sh` — line 3
```bash
CONFDIR="/home/$(whoami)/.config/mango"
```
- Change to `CONFDIR="$HOME/.config/mango"`.

## 3. Path Audit — Cross-module References

### 3.1 `checker.sh`
```bash
cat ~/.config/sdgos/config-overview/options.list   # line 11-13
cat ~/.config/sdgos/config-overview/options.list   # line 14
```
These reference `options.list` which is in this same module (`local/SDG-MANGO-CONF/options.list`). After install both are at the same path — correct.

### 3.2 `browser.sh`
```bash
cat ~/.config/sdgos/config-overview/options.list   # line 10
```
Same as above — references the module's own `options.list` after deployment.

### 3.3 `menu.sh`
```bash
~/.config/sdgos/config-overview/browser.sh {}     # line 13
~/.config/sdgos/config-overview/checker.sh {}      # line 13
```
References browser.sh and checker.sh from the same module — correct.

### 3.4 `layout-switch.sh`
```bash
cat ~/.config/sdgos/tuis/layouts.list               # lines 6, 8
```
References `layouts.list` which is in this module's `local/SDG-MANGO-LAYOUTS/layouts.list`.
**Note:** After install, this file goes to `~/.config/sdgos/tuis/layouts.list` — verify the install.sh copies it to the right place.

## 4. Deploy Path Map

| Source | Destination (after install) |
|--------|---------------------------|
| `local/SDG-DMS-BARS/bar-presets.sh` | `~/.config/sdgos/tuis/bar-presets.sh` |
| `local/SDG-MANGO-CONF/menu.sh` | `~/.config/sdgos/config-overview/menu.sh` |
| `local/SDG-MANGO-CONF/checker.sh` | `~/.config/sdgos/config-overview/checker.sh` |
| `local/SDG-MANGO-CONF/browser.sh` | `~/.config/sdgos/config-overview/browser.sh` |
| `local/SDG-MANGO-CONF/mango-config.sh` | `~/.config/sdgos/mango-config.sh` |
| `local/SDG-MANGO-CONF/options.list` | `~/.config/sdgos/config-overview/options.list` |
| `local/SDG-MANGO-LAYOUTS/layout-switch.sh` | `~/.config/sdgos/tuis/layout-switch.sh` |
| `local/SDG-MANGO-LAYOUTS/layouts.list` | `~/.config/sdgos/tuis/layouts.list` |
| `local/SDG-MANGO-LAYOUTS/layoutbutton.sh` | `~/.config/sdgos/misc/layoutbutton.sh` |
| `local/SDG-MANGO-SWAP/marker.sh` | `~/.config/sdgos/misc/marker.sh` |
| `local/SDG-MANGO-SWAP/swapmarked.sh` | `~/.config/sdgos/misc/swapmarked.sh` |

## 5. Bind Wiring (from SDG-MANGO-CORE/binds.conf)

These binds reference this module's deployed scripts:
- `SUPER+M` → `~/.config/sdgos/mango-config.sh`
- `SUPER+ALT+M` → `~/.config/sdgos/config-overview/menu.sh`
- `SUPER+SHIFT+W` → `~/.config/sdgos/tuis/layout-switch.sh`
- `SUPER+SHIFT+D` → `~/.config/sdgos/tuis/bar-presets.sh`
- `SUPER+SHIFT+J` → `~/.config/sdgos/misc/swapmarked.sh`
- `SUPER+J` → `~/.config/sdgos/misc/marker.sh`
- `SUPER+A` → `~/.config/sdgos/misc/layoutbutton.sh`

## 6. Modular Tips/Help Contribution

### 6.1 Add tips about mango helpers
- Tips about `mangoconf-viewer`, `mangoconf-editor`, layout switching, workspace swapping.
- Create `tips/` directory with entries.

### 6.2 Help topics
- SDG-MANGO-HELPERS already has extensive documentation built into `checker.sh` (261 lines of config option explanations). This is effectively inline help.
- Consider adding a `docs/` directory that documents the available commands.

## 7. Empty Directory Cleanup

| Directory | Status |
|-----------|--------|
| `cache/` | Empty — remove or document |
| `tips/` | Empty — add tips or remove |
| `other/` | Empty — remove or document |
| `docs/` | Empty — remove or document |
