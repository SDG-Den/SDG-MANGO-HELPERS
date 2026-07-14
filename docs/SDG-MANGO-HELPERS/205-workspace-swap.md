# Workspace Swapping

Swap all windows between two workspaces using `marker.sh` + `swapmarked.sh`.

## Workflow

1. **Mark**: Focus the workspace to copy from, then trigger `marker.sh`
2. **Navigate**: Move to the target workspace (different monitor/tag)
3. **Swap**: Trigger `swapmarked.sh` — all windows are exchanged

## marker.sh — Mark Workspace State

```
marker.sh [monitor]
```

- Saves the current workspace's window IDs and `monitor:tag` to state files
- `$1`: optional monitor name (defaults to active monitor via `mmsg`)
- Queries `mmsg get all-monitors`, `mmsg get tags`, `mmsg get all-clients` with `jq`
- Sends `notify-send "monitor <name> marked"`

### State Files

| File | Content |
|------|---------|
| `~/.config/marker.state` | List of window IDs on the marked workspace |
| `~/.config/marker.workspace` | `MONITOR:TAG` string identifying the marked workspace |

## swapmarked.sh — Execute Swap

```
swapmarked.sh
```

No arguments. Reads state files and performs the exchange:

1. Gets current active workspace data (monitor, tag, windows)
2. Reads the marked workspace data from state files
3. Builds paired lists in `MONITOR:TAG:WINDOWID` format
4. Interleaves source and target entries with `paste` + `awk`
5. For each pair:
   - Moves source windows to target via `mmsg dispatch tagcrossmon`
   - Moves target windows to source
   - Applies `viewcrossmon` for cross-monitor transfers
   - Uses `sleep 0.01` between operations for IPC stability

## Multi-Monitor

Both scripts are fully multi-monitor aware. `marker.sh` accepts an optional monitor argument. `swapmarked.sh` dynamically queries all monitors and handles cross-monitor swaps with `viewcrossmon`.

## Dependencies

`mmsg`, `jq`, `notify-send`, `cat`, `cut`, `paste`, `awk`, `sed`
