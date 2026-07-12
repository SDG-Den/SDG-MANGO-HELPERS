#!/bin/bash

# define helpers and variables
GAMMA=2.8

setrgb() {
    local KEY=$1
    local RGB=$2
    echo "rgb $KEY:$RGB" > /dev/input/ckb1/cmd
}

colorsfile=$HOME/.local/SDG-RGB-DAEMON/colors.theme
colorsactive=$HOME/.local/SDG-RGB-DAEMON/colors.active

boost_contrast() {
    local hex=$1
    [ ${#hex} -lt 6 ] && { echo "$hex"; return; }
    python3 << PYEOF
r = int("${hex:0:2}", 16)
g = int("${hex:2:2}", 16)
b = int("${hex:4:2}", 16)
nr = int(((r/255)**$GAMMA) * 255)
ng = int(((g/255)**$GAMMA) * 255)
nb = int(((b/255)**$GAMMA) * 255)
nr = max(0, min(255, nr))
ng = max(0, min(255, ng))
nb = max(0, min(255, nb))
print(f"{nr:02X}{ng:02X}{nb:02X}")
PYEOF
}

enumcolors() {
    primary=$(boost_contrast "$(grep -e "PRIMARY=" "$colorsfile" | cut -d= -f2)")
    primary_dim=$(boost_contrast "$(grep -e "DIM=" "$colorsfile" | cut -d= -f2)")
    alt=$(boost_contrast "$(grep -e "ALT=" "$colorsfile" | cut -d= -f2)")
    alt_dim=$(boost_contrast "$(grep -e "ALTDIM=" "$colorsfile" | cut -d= -f2)")
    ok=$(boost_contrast "$(grep -e "OK=" "$colorsfile" | cut -d= -f2)")
    warn=$(boost_contrast "$(grep -e "WARN=" "$colorsfile" | cut -d= -f2)")
    error=$(boost_contrast "$(grep -e "ERROR=" "$colorsfile" | cut -d= -f2)")
    cat > "$colorsactive" << EOF
primary=$primary
primary_dim=$primary_dim
alt=$alt
alt_dim=$alt_dim
ok=$ok
warn=$warn
error=$error
EOF
    echo "primary: $primary"
    echo "primary_dim: $primary_dim"
    echo "alt: $alt"
    echo "alt_dim: $alt_dim"
    echo "ok: $ok"
    echo "warn: $warn"
    echo "error: $error"
}
# initialize colors
enumcolors

apply_keymode() {
    local mode=$1
    [ -f "$colorsactive" ] && source "$colorsactive"
    case $mode in
        default)
        setrgb a,w,d,s,lshift,rshift,lwin,esc $alt
        setrgb f1,f2,f3,f4 $primary_dim
        ;;
        window)
        setrgb a,w,d,s,lshift,rshift,lwin,f1 $warn
        setrgb f2,f3,f4 $primary_dim
        setrgb esc ff0000
        ;;
        group)
        setrgb a,w,s,d,lshift,rshift,lwin,f2 $error
        setrgb f1,f3,f4 $primary_dim
        setrgb esc ff0000
        ;;
        scripts)
        setrgb a,w,s,d,lshift,rshift,lwin,f3 $primary
        setrgb f1,f2,f4 $primary_dim
        setrgb esc ff0000
        ;;
        theming)
        setrgb a,w,d,s,lshift,rshift,lwin,f4 $ok
        setrgb f1,f2,f3 $primary_dim
        setrgb esc ff0000
        ;;
    esac
}


echo "rgb $primary_dim" > /dev/input/ckb1/cmd
setrgb space,enter,tab,e,b $primary
setrgb q,z $error
setrgb m,h,r $warn
rgbsetrgb f,t,g,p,j $alt
command -v rgbkeys && pamixer --get-volume | awk '{print $1}' | rgbkeys
CURMODE=$(mmsg get keymode | jq -r '.keymode' 2>/dev/null || echo "default")
apply_keymode "$CURMODE"

# watch theme for updates (auto-restart on crash)
while true; do
    inotifywait -q -m -e close_write $HOME/.local/SDG-RGB-DAEMON/colors.theme 2>/dev/null | while read -r filename event; do
        echo "theme changed"
        echo ""
        echo "enum"
        enumcolors
        echo ""
        echo "rgb $primary_dim" > /dev/input/ckb1/cmd
        setrgb space,enter,tab,e,b $primary
        setrgb q,z $error
        setrgb m,h,r $warn
        setrgb f,t,g,p,j $alt
        command -v rgbkeys && pamixer --get-volume | awk '{print $1}' | rgbkeys
        CURMODE=$(mmsg get keymode | jq -r '.keymode' 2>/dev/null || echo "default")
        apply_keymode "$CURMODE"

    done
    sleep 1
done &


# watch keymode for updates (auto-restart on crash)
while true; do
    mmsg watch keymode 2>/dev/null | jq --unbuffered -r '.keymode' | while IFS= read -r line; do
        echo "keymode changed"
        apply_keymode "$line"
    done
    sleep 1
done &


# watch tag for updates (auto-restart on crash)
while true; do
    mmsg watch all-tags 2>/dev/null | while read -r update; do
        echo "update tags"
        [ -f "$colorsactive" ] && source "$colorsactive"

        ACTIVEMON=$(mmsg get all-monitors | jq '.monitors[] | select(.active == true) | .name' -r)
        ACTIVETAGS=$(mmsg get tags "$ACTIVEMON" | jq '.tags[] | select(.is_active == true) | .index' -r)

        ACTIVE=()
        while IFS= read -r tag; do
            ACTIVE+=("$tag")
        done <<< "$ACTIVETAGS"

        for i in {1..9}; do
            if [[ " ${ACTIVE[*]} " =~ " $i " ]]; then
                setrgb "$i" "$primary"
            else
                setrgb "$i" "$primary_dim"
            fi
        done

    done
    sleep 1
done &

while true; do
    sleep 60
    
    echo "rgb $primary_dim" > /dev/input/ckb1/cmd
    setrgb space,enter,tab,e,b $primary
    setrgb q,z $error
    setrgb m,h,r $warn
    rgbsetrgb f,t,g,p,j $alt
    command -v rgbkeys && pamixer --get-volume | awk '{print $1}' | rgbkeys
    CURMODE=$(mmsg get keymode | jq -r '.keymode' 2>/dev/null || echo "default")
    apply_keymode "$CURMODE"
done

