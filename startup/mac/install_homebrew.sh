#!/bin/bash

if [[ $(command -v brew) ]];then
    echo "homebrew is already installed."
else
    echo "start homebrew install"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $(command -v python) ]]; then
        echo "python is already installed."
    else
        brew install python
    fi
    echo "install brew cask"
    curl -fsSkL https://raw.github.com/cask/cask/master/go | python
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    echo "homebrew install done."
fi