#!/bin/bash

## install exa
if [[ $(command -v exa) ]]; then
    echo "exa is already installed."
else
    echo "install exa"
    case $1 in
        "mac")
            brew install exa;;
        *)
            wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
            unzip exa-linux-x86_64-v0.10.0.zip -d ~/exa
            sudo mv -f ~/exa/bin/exa /usr/local/bin/exa
            rm -rf ~/exa;;
    esac
fi