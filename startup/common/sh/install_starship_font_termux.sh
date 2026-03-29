#!/bin/bash

## download Nerd Font for Termux
echo "Download fonts..."
echo "use JetBrainsMono Nerd Font"

mkdir -p ~/.termux
curl -fLo ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf

termux-reload-settings

echo "Font Install Done!"
