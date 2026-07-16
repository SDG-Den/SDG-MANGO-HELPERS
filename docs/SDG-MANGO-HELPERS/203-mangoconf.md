# mangoconf — Config File Browser & Editor

**What this is for:** Your desktop settings are stored in configuration files. This tool lets you browse and edit them without needing to remember file paths or use a separate text editor.

Opens an interactive menu to browse and edit mangoWM configuration files.

## Usage

```
mangoconf
```

No arguments. Lists all files in `~/.config/mango/` with `bat` syntax-highlighted previews.

## Workflow

1. `fzf` lists config files from `~/.config/mango/`
2. Right pane shows a `bat` preview of the highlighted file
3. Press Enter to open the selected file in `micro`
4. After editing and closing `micro`, you return to the file list

## Dependencies

`fzf`, `bat`, `micro`

## Related Keybinds

Configured in SDG-MANGO-CORE:
- `SUPER + M` — launch mangoconf
