#!/bin/bash

## install starship
echo "Install starship..."

SCRIPT_DIR=$(cd $(dirname $0); pwd)

if [[ $(command -v starship) ]]; then
    echo "starship is already installed."
else
    curl -sS https://starship.rs/install.sh | sh
fi

ln -nsf $SCRIPT_DIR/../../../starship/ ~/.starshipconf

echo "Install starship Done!"