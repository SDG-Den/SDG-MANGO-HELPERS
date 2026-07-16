# layoutbutton.sh — Bar Widget Layout Indicator

**What this is for:** Shows the current window layout on your bar and can run automatic actions depending on which layout is active — for example, grouping all windows when you switch to fair layout.

Queries the active monitor's layout and executes per-layout side effects. Designed to be used as a bar widget or bound to a key.

```
~/.local/SDG-MANGO-LAYOUTS/layoutbutton.sh
```

## How It Works

1. Gets the active monitor name via `mmsg get all-monitors | jq`
2. Gets the layout code for that monitor via `mmsg get monitor <name> | jq`
3. Maps the layout code to a side effect and calls it

## Layout → Side Effect Mapping

| Layout | Code | Side Effect | Description |
|--------|------|-------------|-------------|
| Left Master | `T` | `zoom` | Focus master window |
| Horizontal Scroller | `S` | `switch_proportion_preset` | Cycle proportion presets |
| Horizontal Grid | `G` | `toggle_render_border` + `togglegaps` | Toggle borders + gaps |
| Monocle | `M` | *(none)* | No action needed |
| Horizontal Deck | `K` | `zoom` | Focus active deck window |
| Center Master | `CT` | `zoom` | Focus master window |
| Right Master | `RT` | `zoom` | Focus master window |
| Vertical Scroller | `VS` | `switch_proportion_preset` | Cycle proportion presets |
| Top Master | `VT` | `zoom` | Focus master window |
| Vertical Grid | `VG` | `toggle_render_border` + `togglegaps` | Toggle borders + gaps |
| Vertical Deck | `VK` | `zoom` | Focus active deck window |
| Dwindle | `DW` | `togglemaximizescreen` | Toggle maximized state |
| Fair | `F` | `group-all.sh` | Group all windows |
| Vertical Fair | `VF` | `group-all.sh` | Group all windows |
| *(unknown)* | * | `notify-send` warning | Unhandled layout detected |


## Dependencies

`mmsg`, `jq`, `notify-send`
