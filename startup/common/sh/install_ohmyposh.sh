#!/bin/bash

## install oh-my-posh
## https://ohmyposh.dev/docs/installation/linux

if command -v oh-my-posh &>/dev/null; then
    echo "oh-my-posh is already installed."
else
    echo "Installing oh-my-posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
    echo "oh-my-posh installed successfully."
fi
