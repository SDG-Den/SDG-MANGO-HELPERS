# Window Grouping

Two scripts for managing window groups on a monitor.

## group-all.sh — Group All Windows

Groups every window on the active monitor into a single group. Designed for Fair layouts (horizontal and vertical) — automatically triggered by `layoutbutton.sh` when switching to a Fair layout.

```
~/.local/SDG-MANGO-GROUPS/group-all.sh
```

### Algorithm

Repeatedly merges out-of-position windows in all 4 directions:

1. **Down**: If window bottom ≠ total height → focus → focus down → groupjoin up
2. **Up**: If window top ≠ EXPY → focus → focus up → groupjoin down
3. **Left**: If window left ≠ EXPX → focus → focus left → groupjoin right
4. **Right**: If window right edge ≠ total width → focus → focus right → groupjoin left

Uses `mmsg dispatch groupjoin,<direction>` for each merge. Sleeps `0.00` between operations. Exits `0` when all windows match expected dimensions.

### Monitor-Specific X Offsets

| Monitor | EXPX |
|---------|------|
| DP-2 | 4 |
| HDMI-A-1 | 1924 |
| DP-3 | 3844 |

## group-merge.sh — Merge Window into Group

Merges the focused window with an adjacent window by direction.

```
group-merge.sh <direction>
```

Arguments: `left`, `right`, `up`, or `down`

Each direction focuses the neighbor then groupjoins from the opposite direction:

| Argument | Action |
|----------|--------|
| `left` | `focusdir left` → `groupjoin right` |
| `right` | `focusdir right` → `groupjoin left` |
| `up` | `focusdir up` → `groupjoin down` |
| `down` | `focusdir down` → `groupjoin up` |

### Use Cases

- **group-all.sh**: Bind to a key for ad-hoc grouping, or let `layoutbutton.sh` trigger it automatically for Fair layouts
- **group-merge.sh**: Bind directional keys to merge windows into groups incrementally

## Dependencies

`mmsg`, `jq`
