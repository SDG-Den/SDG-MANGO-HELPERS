# SDG-MANGO-HELPERS Analysis

## 1. Functions

| Function | File | Lines | Purpose |
|----------|------|-------|---------|
| `dmsbars` (symlink) | `local/SDG-DMS-BARS/bar-presets.sh` | 1–92 | TUI via fzf to toggle individual bars (top, taskbar, status, L/R sidebar, dock) or apply 6 presets (classic, windows-like, mac-like, combo, sidebar, side+status). Communicates via `dms ipc call`. |
| `manlayout` (symlink) | `local/SDG-MANGO-LAYOUTS/layout-switch.sh` | 1-10 | fzf-based layout chooser. Reads `layouts.list`, parses `name \| command` pairs, runs chosen layout dispatcher via `mmsg dispatch setlayout`. |
| `layoutbutton.sh` (no symlink) | `local/SDG-MANGO-LAYOUTS/layoutbutton.sh` | 1-76 | Reads the active monitor's current layout via `mmsg`, prints name, runs layout-specific actions (zoom, togglegaps, etc.). Used as a widget/indicator. |
| `manconf` (symlink) | `local/SDG-MANGO-CONF/mango-config.sh` | 1-15 | fzf + bat preview to browse & edit (`micro`) files in `~/.config/mango/`. |
| `manmenu` (symlink) | `local/SDG-MANGO-CONF/menu.sh` | 1-15 | Interactive config key explainer. Reads a config file, lets user select a line, runs `checker.sh` for explanation and `browser.sh` for docs via alt+b. |
| `checker.sh` (helper) | `local/SDG-MANGO-CONF/checker.sh` | 1-261 | Parses a config key, looks it up in `options.list`, prints example, description, docs link, and extended `EXTRA` info (bind, monitor, dwindle, master, scroller, tearing, env, animations, bezier, windowrules, tagrules, layerrules, scratchpad, overview, autostart). |
| `browser.sh` (helper) | `local/SDG-MANGO-CONF/browser.sh` | 1-12 | Parses a config key, extracts the docs URL from `options.list`, opens in Firefox. |
| `marker.sh` (no symlink) | `local/SDG-MANGO-SWAP/marker.sh` | 1-21 | Captures active monitor/tag/client IDs via `mmsg` and saves to state files. |
| `swapmarked.sh` (no symlink) | `local/SDG-MANGO-SWAP/swapmarked.sh` | 1-72 | Reads marker state, exchanges all windows between current and saved workspace using `mmsg dispatch tagcrossmon`. |
| `install.sh` | `install.sh` | 1-42 | Installs dependencies via `unipkg` (fzf, bat, jq, micro), copies `local/` to `~/.local/`, copies docs/tips, chmods scripts, symlinks 4 entrypoints to `/usr/bin`. |
| `uninstall.sh` | `uninstall.sh` | 1-13 | Removes `~/.local/SDG-*` dirs, docs/tips, and unlinks `/usr/bin` symlinks. |
| `update.sh` | `update.sh` | 1-21 | Removes old `~/.local/SDG-*` dirs, re-copies `local/`, re-symlinks, re-copies docs/tips. |
| `detect.sh` | `detect.sh` | 1-20 | Checks for required commands: `mmsg`, `mango`, `dms`, `fzf`, `bat`, `jq`, `micro`. |

## 2. Dependencies

| Dependency | Used by | Purpose |
|------------|---------|---------|
| `unipkg` | `install.sh:4-7` | Package manager to fulfill dependencies |
| `fzf` | `install.sh:4`, `bar-presets.sh:17`, `layout-switch.sh:6`, `mango-config.sh:8`, `menu.sh:9` | Interactive TUI selection |
| `bat` | `install.sh:5`, `mango-config.sh:8`, `menu.sh:9` | File preview (bat as pager) |
| `jq` | `install.sh:6`, `marker.sh:5-8`, `swapmarked.sh:3-5,49`, `layoutbutton.sh:4,8` | JSON parsing for `mmsg` IPC output |
| `micro` | `install.sh:7`, `mango-config.sh:6,12`, `menu.sh:6` | Default text editor for config files |
| `mmsg` | `detect.sh:14`, `layout-switch.sh:4,8`, `marker.sh:5-8`, `swapmarked.sh:3-5,50-68`, `layoutbutton.sh:4,8`, `options.list` examples | mangoWM IPC message client |
| `dms` | `detect.sh:16`, `bar-presets.sh:21-89` | DankMaterial Shell IPC client |
| Web browser (Firefox, hardcoded) | `browser.sh:12` | Opens MangoWM documentation URLs |

## 3. Dependents (repos referencing SDG-MANGO-HELPERS)

| Repo | File | Context |
|------|------|---------|
| `SDG-OS-META` | `install.sh:15` | `sdgpkg install sdg-mango-helpers` — part of the full OS bootstrap |
| `SDG-REPO` | `SDGOS.repo:13` | Package registry entry (`sdg-mango-helpers` → git URL + README URL) |
| `SDG-REPO-OLD` | `SDGOS.repo:13`, `migration-plan.md:22` | Old repo copy — same registry entry |
| `SDG-MANGO-CORE` | `migration-plan.md:25-36,76` | Remaps 7 scripts from old `~/.config/sdgos/` paths to new `~/.local/SDG-*/` paths |
| `SDG-TERM` | `migration-plan.md:34` | Remaps old `~/.config/sdgos/mango-config.sh` → `~/.local/SDG-MANGO-CONF/mango-config.sh` |
| `SDG-DOCS` | `docs/SDG-DOC-DEVS/01-architecture-overview.md:13`, `docs/SDG-DOC-TINKERERS/02-configuring-modules.md:42` | Architecture docs listing mangoWM config computer as SDG-MANGO-HELPERS |
| `GLOBAL-MIGRATION-GUIDE.md` | `Line 38-143` | Long table remapping every helper path from old to new layout |

## 4. Use / Configuration

- **Entry points** (symlinked to `/usr/bin`): `dmsbars`, `manlayout`, `manconf`, `manmenu`
- **No symlink, called internally**: `layoutbutton.sh` (by bar widgets), `marker.sh`/`swapmarked.sh` (by keybinds), `checker.sh`/`browser.sh` (by `menu.sh`)
- **Config directory** (`~/.config/mango/`): browsed/edited by `mango-config.sh:3` and `menu.sh:3`
- **State files** (marker/swap): `~/.config/marker.state` and `~/.config/marker.workspace` (written by `marker.sh:15-16`, read by `swapmarked.sh:8-10`)
- **Internal reference data**: `~/.local/SDG-MANGO-CONF/options.list` (232 lines of mangoWM config key documentation with examples, descriptions, URLs, extra info tags)
- **Layout data**: `~/.local/SDG-MANGO-LAYOUTS/layouts.list` (14 layout entries in `name | command` format)
- **Keybinds** (expected in user's mango config): binds to invoke `marker.sh`, `swapmarked.sh`, and the four entrypoint commands
- **Tips** (4 files): `bar-presets.md`, `config-editor.md`, `layout-switching.md`, `workspace-swapping.md` — installed to `~/.local/tips/SDG-MANGO-HELPERS/`
- **Docs** (1 file): `docs/SDG-MANGO-HELPERS/README.md` — installed to `~/.local/docs/SDG-MANGO-HELPERS/`

## 5. Deprecation / Outdated Items

| Issue | File | Line(s) | Detail |
|-------|------|---------|--------|
| Empty README.md | `README.md` | 1-2 | Heading only, no content. A separate docs file exists at `docs/SDG-MANGO-HELPERS/README.md`,
| Empty `config/` | `config/` | — | Directory exists but is empty. Likely leftover or placeholder. |
| Empty `TESTCOMPLETE.md` | `TESTCOMPLETE.md` | — | Zero-length file at root — unclear intent. |
| Old `~/.config/sdgos/` references in examples | `options.list:5` | `exec=bash ~/.config/sdgos/script.sh` | Example still references legacy path. |
| Old `~/.config/sdgos/` references in examples | `options.list:185` | `bind=MOD,KEY,spawn_shell,'ghostty -e ~/.config/sdgos/tuis/pkg-install.sh'` | Example still references legacy path. |
| Hardcoded Firefox | `browser.sh:12` | `firefox --new-tab $LINK` | Should be `xdg-open` or configurable browser. |
| Marker state files in `~/.config/` (not `~/.local/`) | `marker.sh:15-16` | `~/.config/marker.state`, `~/.config/marker.workspace` | Inconsistent with XDG. Should use `~/.local/state/` or at minimum `$XDG_STATE_HOME`. |
| Old path in `options.list:5` | `options.list:5` | `exec=bash ~/.config/sdgos/script.sh` — the example references old SDG-OS layout that no longer exists. |
| No shebang in `browser.sh` | `browser.sh:1` | Misses `#!/bin/bash` — all other `.sh` files have one. |
| Pre-existing `#mmsg` comment in `layout-switch.sh` | `layout-switch.sh:3` | `#mmsg dispatch togglefloating` — appears to be a draft/test line commented out. |

### Migration Status (from `migration-plan.md`)

All path rewrites listed in `migration-plan.md` have been applied:
- `$HOME` replaces hardcoded `/home/$(whoami)/` in `menu.sh:3` and `mango-config.sh:3` ✓
- Internal `~/.config/sdgos/config-overview/` → `~/.local/SDG-MANGO-CONF/` completed in `checker.sh:11-14`, `browser.sh:10`, `menu.sh:13` ✓
- Internal `~/.config/sdgos/tuis/layouts.list` → `~/.local/SDG-MANGO-LAYOUTS/layouts.list` completed in `layout-switch.sh:6,8` ✓
- Lifecycle scripts (`install.sh`, `uninstall.sh`, `update.sh`, `detect.sh`) all implemented ✓
- Tips directory populated with 4 files ✓
- `cache/` and `other/` dirs do not exist in repo — already removed ✓
- Docs directory populated (1 README) ✓