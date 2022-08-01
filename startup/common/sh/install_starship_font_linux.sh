#!/bin/bash

## download font.
echo "Download fonts..."
echo "use JetBrainsMono"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.fonts
echo "Update font cache."
fc-cache -fv
echo "Font Install Done!"
