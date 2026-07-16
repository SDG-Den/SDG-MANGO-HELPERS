# options.list — Config Option Reference Database

**What this is for:** This is the data file that powers `mangoconf view`. You can browse it directly if you want to see all configuration options at once. It is not meant to be run directly.

Reference database powering `mangoconf view`.

## Location

```
~/.local/SDG-MANGO-CONF/options.list
```

## Format

5 pipe-delimited fields per line:

```
key_name | example_usage | description | doc_url | extra_category
```

| Field | Content | Used by |
|-------|---------|---------|
| 1 | Config key name (e.g. `bind`, `gappih`) | Lookup key |
| 2 | Example usage (e.g. `bind=SUPER,Q,killclient`) | Preview |
| 3 | Description of what the option does | `checker.sh` fallback |
| 4 | Documentation URL (`https://mangowm.github.io/docs/...`) | `browser.sh` |
| 5 | Extra info category (optional) | `checker.sh` detailed help |

## Categories Covered

- **General** (source, env, exec-once, exec)
- **Tearing** (allow_tearing)
- **Input** (repeat_rate, xkb_*, mouse_*, cursor_*, trackpad_*, touchpad_*, swipe_*, click_*, scroll_*, button_map, drag_*, grip_*, etc.)
- **Misc** (xwayland, syncobj, focus, cursor, drag, snap, scratchpad, idleinhibit)
- **Visuals/Theming** (borderpx, radius, opacity, gaps, colors — rootcolor, bordercolor, focuscolor, etc.)
- **Effects** (blur, shadows — all variants)
- **Layouts** (scroller_*, master_*, dwindle_*, smartgaps, mfact, nmaster, etc.)
- **Overview** (hotarea_*, ov_*)
- **Bindings** (bind, keymode, mousebind, axisbind, gesturebind, switchbind)
- **Monitors** (monitorrule)
- **Dispatchers** (killclient, togglefloating, togglefullscreen, focusdir, focusstack, zoom, view, tag, setlayout, incmaster, setmfact, spawn, togglegaps, etc.)
- **Rules** (windowrule, tagrule, layerrule)
- **Animations** (animation_type_*, animation_duration_*, animation_curve_*, fade, zoom)

## Extra Info Categories (Field 5)

Used by `checker.sh` to show detailed contextual help:

`bind`, `monitor`, `dwindle`, `master`, `scroller`, `tearing`, `env`, `animations`, `bezier`, `windowrules`, `tagrules`, `layerrules`, `scratchpad`, `overview`, `autostart`

## How to Extend

Add a new line following the 5-field format:

```
myoption | myoption=value | What this option does | https://mangowm.github.io/docs/#myoption | category
```
