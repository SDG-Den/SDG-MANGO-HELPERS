# manlayout — Layout Switcher

**What this is for:** Windows can be arranged in different patterns — side by side, in a grid, stacked, or fullscreen. This tool lets you switch between layouts to find what works best for what you are doing.

Opens an interactive menu to switch between window layouts.

## Usage

```
manlayout
```

Reads layout definitions from `~/.local/SDG-MANGO-LAYOUTS/layouts.list`.

## Layout Reference

| Layout | mmsg command | Description |
|--------|--------------|-------------|
| Scroller - horizontal | `mmsg dispatch setlayout,scroller` | Windows arranged in an infinite horizontal strip; scroll to navigate |
| Scroller - vertical | `mmsg dispatch setlayout,vertical_scroller` | Same as above but vertical |
| Tile/master - left | `mmsg dispatch setlayout,tile` | Master on left, tiled secondaries on right |
| Tile/master - top | `mmsg dispatch setlayout,vertical_tile` | Master on top, tiled secondaries below |
| Tile/master - center | `mmsg dispatch setlayout,center_tile` | Master centered, secondaries stacked on both sides |
| Tile/master - right | `mmsg dispatch setlayout,right_tile` | Master on right, tiled secondaries on left |
| Grid - horizontal | `mmsg dispatch setlayout,grid` | Windows tiled in rows |
| Grid - vertical | `mmsg dispatch setlayout,vertical_grid` | Windows tiled in columns |
| Deck - horizontal | `mmsg dispatch setlayout,deck` | Windows overlapping like cards, horizontally |
| Deck - vertical | `mmsg dispatch setlayout,vertical_deck` | Same but vertical stacking |
| Fair - horizontal | `mmsg dispatch setlayout,fair` | All windows equally sized in rows |
| Fair - vertical | `mmsg dispatch setlayout,vertical_fair` | All windows equally sized in columns |
| Monocle | `mmsg dispatch setlayout,monocle` | Single window fullscreen at a time |
| Dwindle | `mmsg dispatch setlayout,dwindle` | Binary-tree splitting; new windows split the focused container |

## Use Case Notes

- **Scroller**: Good for many windows where you only need to see one at a time + scroll to find others
- **Tile/Master**: Traditional productivity layout — one main window + secondary windows
- **Grid/Deck**: Balanced multi-window views
- **Fair**: Equal window distribution; automatically triggers window grouping via `layoutbutton.sh`
- **Monocle**: Focus on a single window; navigate with focus cycling
- **Dwindle**: Space-efficient for deeply nested window arrangements

## Dependencies

`fzf`, `mmsg`, `cat`, `cut`, `grep`
