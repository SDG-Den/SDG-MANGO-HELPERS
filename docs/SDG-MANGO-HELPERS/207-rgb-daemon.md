# RGB Daemon

**What this is for:** If your keyboard has RGB lighting, this daemon can sync it with your desktop theme — changing colors automatically when you switch wallpapers or modes.

Daemons for syncing keyboard lighting with mangoWM state.

## v1 — rgb-daemon.sh (ckb-next)

Watches mangoWM keymode and sets ckb-next keyboard mode accordingly.

```
~/.local/SDG-RGB-DAEMON/rgb-daemon.sh
```

- Watches `mmsg watch keymode` with `jq --unbuffered -r '.keymode'`
- Calls `ckb-next -m <mode>` when keymode changes
- Skips redundant calls (only fires on change)
- Runs until killed (streaming watcher)

**Hardware**: ckb-next compatible keyboards

## v2 — rgb-daemon-v2.sh (ckb1)

Advanced daemon for ckb1 hardware. Watches theme files, keymode, and active tags simultaneously.

```
~/.local/SDG-RGB-DAEMON/rgb-daemon-v2.sh
```

### Hardware

Writes to `/dev/input/ckb1/cmd` (ckb1 device). Requires the ckb1 kernel driver.

### Color Source

Reads from `colors.theme` in the same directory:

```
PRIMARY=ff0000
DIM=aa0000
ALT=00ff00
ALTDIM=00aa00
OK=00ff00
WARN=ffff00
ERROR=ff0000
```

A template at `~/.local/SDG-RGB-DAEMON/template.theme` contains material design color placeholders for automated substitution.

### Gamma Correction

`GAMMA=2.8` — all colors are boosted via `boost_contrast()` using Python to compensate for LED brightness curves.

### Keymode Layouts

Different key highlighting per mode:

| Mode | Highlighted keys |
|------|-----------------|
| `default` | WASD+modifiers (alt), F1-F4 (primary_dim) |
| `window` | WASD+modifiers+F1 (warn), F2-F4 (primary_dim), Esc (error/red) |
| `group` | WASD+modifiers+F2 (error), F1/F3/F4 (primary_dim), Esc (red) |
| `scripts` | WASD+modifiers+F3 (primary), F1/F2/F4 (primary_dim), Esc (red) |
| `theming` | WASD+modifiers+F4 (ok), F1-F3 (primary_dim), Esc (red) |

### Static Key Assignments

Keys lit regardless of keymode:

| Color | Keys |
|-------|------|
| primary | space, enter, tab, e, b |
| error | q, z |
| warn | m, h, r |
| alt | f, t, g, p, j |
| primary_dim | background |

### Tag Indicators

Number keys 1-9 are lit to show active vs inactive tags:
- **primary** if the tag is active
- **primary_dim** if inactive

### Five Parallel Watchers

| Watcher | Mechanism | Action |
|---------|-----------|--------|
| Theme | `inotifywait -q -m -e close_write` on `colors.theme` | Re-extract colors, reapply all |
| Keymode | `mmsg watch keymode` | Apply keymode layout |
| Tags | `mmsg watch all-tags` | Update number key indicators |
| Volume Keys | `mmsg watch` on volume events | Refresh volume key RGB when volume changes (optional) |
| Refresh | `sleep 60` loop | Reapply keymode + main keys every 60s |

## Autostart

Add to mangoWM config:

```
exec-once = ~/.local/SDG-RGB-DAEMON/rgb-daemon.sh
```

or for v2:

```
exec-once = ~/.local/SDG-RGB-DAEMON/rgb-daemon-v2.sh
```

## Dependencies

- **v1**: `ckb-next`, `mmsg`, `jq`
- **v2**: `python3`, `inotifywait`, `mmsg`, `jq`, ckb1 device driver
