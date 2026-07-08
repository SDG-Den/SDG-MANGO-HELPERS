#!/bin/bash

rm -rf "$HOME/.local/SDG-DMS-BARS"
rm -rf "$HOME/.local/SDG-MANGO-LAYOUTS"
rm -rf "$HOME/.local/SDG-MANGO-CONF"
rm -rf "$HOME/.local/SDG-MANGO-SWAP"
rm -rf "$HOME/.local/docs/SDG-MANGO-HELPERS"
rm -rf "$HOME/.local/tips/SDG-MANGO-HELPERS"

sudo unlink /usr/bin/dmsbars
sudo unlink /usr/bin/manlayout
sudo unlink /usr/bin/manconf
sudo unlink /usr/bin/manmenu
