#!/bin/bash

WORKDIR="$HOME/.cache/SDG-PKG/sdg-mango-helpers"

rm -rf "$HOME/.local/SDG-DMS-BARS" \
      "$HOME/.local/SDG-MANGO-LAYOUTS" \
      "$HOME/.local/SDG-MANGO-CONF" \
      "$HOME/.local/SDG-MANGO-SWAP"
cp -r "$WORKDIR/local/"* "$HOME/.local/"

rm -rf "$HOME/.local/docs/SDG-MANGO-HELPERS" "$HOME/.local/tips/SDG-MANGO-HELPERS"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

sudo ln -sf "$HOME/.local/SDG-DMS-BARS/bar-presets.sh" /usr/bin/dmsbars
sudo ln -sf "$HOME/.local/SDG-MANGO-LAYOUTS/layout-switch.sh" /usr/bin/manlayout
sudo ln -sf "$HOME/.local/SDG-MANGO-CONF/mango-config.sh" /usr/bin/manconf
sudo ln -sf "$HOME/.local/SDG-MANGO-CONF/menu.sh" /usr/bin/manmenu
