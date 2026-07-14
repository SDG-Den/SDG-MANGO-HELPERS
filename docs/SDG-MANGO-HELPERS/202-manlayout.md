# manlayout — Layout Switcher

Opens an fzf TUI to switch between window layouts via mangoWM IPC.

## Usage

```
manlayout
```

Reads layout definitions from `~/.local/SDG-MANGO-LAYOUTS/layouts.list`.

## Layout Reference

| # | Layout | mmsg command | Description |
|---|--------|--------------|-------------|
| 1 | Scroller - horizontal | `mmsg dispatch setlayout,scroller` | Windows arranged in an infinite horizontal strip; scroll to navigate |
| 2 | Scroller - vertical | `mmsg dispatch setlayout,vertical_scroller` | Same as above but vertical |
| 3 | Tile/master - left | `mmsg dispatch setlayout,tile` | Master on left, tiled secondaries on right |
| 4 | Tile/master - top | `mmsg dispatch setlayout,vertical_tile` | Master on top, tiled secondaries below |
| 5 | Tile/master - center | `mmsg dispatch setlayout,center_tile` | Master centered, secondaries stacked on both sides |
| 6 | Tile/master - right | `mmsg dispatch setlayout,right_tile` | Master on right, tiled secondaries on left |
| 7 | Grid - horizontal | `mmsg dispatch setlayout,grid` | Windows tiled in rows |
| 8 | Grid - vertical | `mmsg dispatch setlayout,vertical_grid` | Windows tiled in columns |
| 9 | Deck - horizontal | `mmsg dispatch setlayout,deck` | Windows overlapping like cards, horizontally |
| 10 | Deck - vertical | `mmsg dispatch setlayout,vertical_deck` | Same but vertical stacking |
| 11 | Fair - horizontal | `mmsg dispatch setlayout,fair` | All windows equally sized in rows |
| 12 | Fair - vertical | `mmsg dispatch setlayout,vertical_fair` | All windows equally sized in columns |
| 13 | Monocle | `mmsg dispatch setlayout,monocle` | Single window fullscreen at a time |
| 14 | Dwindle | `mmsg dispatch setlayout,dwindle` | Binary-tree splitting; new windows split the focused container |

## Use Case Notes

- **Scroller**: Good for many windows where you only need to see one at a time + scroll to find others
- **Tile/Master**: Traditional productivity layout — one main window + secondary windows
- **Grid/Deck**: Balanced multi-window views
- **Fair**: Equal window distribution; automatically triggers window grouping via `layoutbutton.sh`
- **Monocle**: Focus on a single window; navigate with focus cycling
- **Dwindle**: Space-efficient for deeply nested window arrangements

## Dependencies

`fzf`, `mmsg`, `cat`, `cut`, `grep`
