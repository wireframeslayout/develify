#!/bin/bash

## install starship
echo "Install starship..."

if [[ $(command -v starship) ]]; then
    echo "starship is already installed."
else
    curl -sS https://starship.rs/install.sh | sh
fi

echo "Install starship Done!"