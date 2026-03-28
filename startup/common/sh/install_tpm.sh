#!/bin/bash

## install tpm (Tmux Plugin Manager)
## https://github.com/tmux-plugins/tpm

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
    echo "tpm is already installed."
else
    echo "Installing tpm..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "tpm installed successfully."
    echo "Start tmux and press 'prefix + I' to install plugins."
fi
