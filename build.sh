#!/bin/bash

LOCALDIR=SDG-MANGO-HELPERS
DOCDIR=SDG-MANGO-HELPERS
TIPDIR=SDG-MANGO-HELPERS

WORKDIR=$(pwd)

rm -rf "$HOME/.local/docs/$DOCDIR" "$HOME/.local/tips/$TIPDIR" \
  "$HOME/.local/SDG-DMS-BARS" "$HOME/.local/SDG-MANGO-CONF" \
  "$HOME/.local/SDG-MANGO-GROUPS" "$HOME/.local/SDG-MANGO-LAYOUTS" \
  "$HOME/.local/SDG-MANGO-SWAP" "$HOME/.local/SDG-RGB-DAEMON" \
  "$HOME/.local/matugen"

cp -r "$WORKDIR/config/"* "$HOME/.config/" 2>/dev/null || true
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

mkdir -p "$HOME/.local/matugen"
cp -r "$WORKDIR/matugen/"* "$HOME/.local/matugen/" 2>/dev/null || true

chmod a+x "$HOME/.local/SDG-DMS-BARS/bar-presets.sh"
chmod a+x "$HOME/.local/SDG-MANGO-LAYOUTS/layout-switch.sh" "$HOME/.local/SDG-MANGO-LAYOUTS/layoutbutton.sh"
chmod a+x "$HOME/.local/SDG-MANGO-CONF/"*.sh
chmod a+x "$HOME/.local/SDG-MANGO-SWAP/"*.sh

sudo ln -sf "$HOME/.local/SDG-DMS-BARS/bar-presets.sh" /usr/bin/dmsbars
sudo ln -sf "$HOME/.local/SDG-MANGO-LAYOUTS/layout-switch.sh" /usr/bin/manlayout
sudo ln -sf "$HOME/.local/SDG-MANGO-CONF/mangocli.sh" /usr/bin/mangoconf

which dmsbars || echo "INSTALL FAILED!"
which manlayout || echo "INSTALL FAILED!"
which mangoconf || echo "INSTALL FAILED!"
