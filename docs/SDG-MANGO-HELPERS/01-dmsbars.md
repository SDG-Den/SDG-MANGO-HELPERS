# dmsbars — Bar Preset Manager

Opens an fzf TUI to toggle individual DMS bars or apply full bar presets.

## Usage

```
dmsbars
```

No arguments. Select an action from the fzf menu.

## Individual Bar Toggles

| Menu Entry | Bar | dms command |
|------------|-----|-------------|
| Toggle Default Top Bar | index 0 | `dms ipc call bar toggle index 0` |
| Toggle Taskbar Style Bar | index 1 | `dms ipc call bar toggle index 1` |
| Toggle Top Status Bar | index 2 | `dms ipc call bar toggle index 2` |
| Toggle Left Side Bar | index 3, left | `dms ipc call bar toggle index 3` + `setPosition left` |
| Toggle Right Side Bar | index 3, right | `dms ipc call bar toggle index 3` + `setPosition right` |
| Toggle Dock | dock | `dms ipc call dock toggle` |

## Bar Presets

| Preset | Bars shown | Dock |
|--------|------------|------|
| classic | index 0 (Default Top Bar) | hidden |
| windows-like | index 1 (Taskbar) | hidden |
| mac-like | index 2 (Status Bar) | revealed |
| combo | index 1 + 2 (Taskbar + Status) | hidden |
| sidebar | index 3 left (Side Bar) | hidden |
| side+status | index 2 + 3 (Status + Side Bar) | hidden |

Each preset sends a `notify-send` notification on apply.

## Dependencies

`fzf`, `dms`, `notify-send`
