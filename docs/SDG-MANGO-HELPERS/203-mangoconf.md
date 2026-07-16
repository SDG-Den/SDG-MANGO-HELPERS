# mangoconf — Config File Browser & Editor

**What this is for:** Your desktop settings are stored in configuration files. This tool lets you browse and edit them without needing to remember file paths or use a separate text editor.

Opens an interactive menu to browse and edit mangoWM configuration files. Both `view` and `edit` share the same top-level file picker with syntax-highlighted previews.

## Usage

```
mangoconf view     — Browse config files and view line-by-line explanations
mangoconf edit     — Browse config files and open one in an editor
mangoconf help     — Show usage
```

## Workflow

### mangoconf edit

1. `fzf` lists config files from `~/.config/mango/`
2. Right pane shows a `bat` preview of the highlighted file
3. Press Enter to open the selected file in `$EDITOR`
4. After editing and closing the editor, you return to the file list
5. Press Esc or Ctrl+C on the file list to exit

### mangoconf view

1. `fzf` lists config files from `~/.config/mango/`
2. Right pane shows a `bat` preview of the highlighted file
3. Press Enter to select a file, then browse its lines with explanations in the preview pane
4. Press `Alt+b` while a line is selected to open its documentation URL in Firefox
5. Press Esc to go back to the file list, or again to exit

## Dependencies

`fzf`, `bat`, `micro` (or `$EDITOR`), `checker.sh`, `browser.sh`

## Related Keybinds

Configured in SDG-MANGO-CORE:
- `SUPER + M` — launch mangoconf edit
- `SUPER + ALT + M` — launch mangoconf view
