#!/bin/bash

### dependencies
unipkg install any fzf
unipkg install any bat
unipkg install any jq
unipkg install any micro

WORKDIR="$HOME/.cache/SDG-PKG/sdg-mango-helpers"

cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

mkdir -p "$HOME/.local/matugen"
cp -r "$WORKDIR/matugen/"* "$HOME/.local/matugen/"


chmod a+x "$HOME/.local/SDG-DMS-BARS/bar-presets.sh"
chmod a+x "$HOME/.local/SDG-MANGO-LAYOUTS/layout-switch.sh"
chmod a+x "$HOME/.local/SDG-MANGO-LAYOUTS/layoutbutton.sh"
chmod a+x "$HOME/.local/SDG-MANGO-CONF/mango-config.sh"
chmod a+x "$HOME/.local/SDG-MANGO-CONF/menu.sh"
chmod a+x "$HOME/.local/SDG-MANGO-CONF/checker.sh"
chmod a+x "$HOME/.local/SDG-MANGO-CONF/browser.sh"
chmod a+x "$HOME/.local/SDG-MANGO-SWAP/marker.sh"
chmod a+x "$HOME/.local/SDG-MANGO-SWAP/swapmarked.sh"

sudo ln -sf "$HOME/.local/SDG-DMS-BARS/bar-presets.sh" /usr/bin/dmsbars
sudo ln -sf "$HOME/.local/SDG-MANGO-LAYOUTS/layout-switch.sh" /usr/bin/manlayout
sudo ln -sf "$HOME/.local/SDG-MANGO-CONF/mango-config.sh" /usr/bin/manconf
sudo ln -sf "$HOME/.local/SDG-MANGO-CONF/menu.sh" /usr/bin/manmenu

which dmsbars || echo "INSTALL FAILED!"
which manlayout || echo "INSTALL FAILED!"
which manconf || echo "INSTALL FAILED!"
which manmenu || echo "INSTALL FAILED!"
