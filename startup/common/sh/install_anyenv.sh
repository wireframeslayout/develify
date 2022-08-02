#!/bin/bash

if [ -e "$HOME/.anyenv" ]; then
    echo "anyenv is already installed."
else
    git clone https://github.com/anyenv/anyenv ~/.anyenv
fi