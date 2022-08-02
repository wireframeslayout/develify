#!/bin/bash

echo "WSL Install Start."

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## synbolic links
ln -sf ~/develify/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/develify/dotfiles/.bashrc_wsl ~/.bashrc
ln -sf ~/develify/dotfiles/.dircolors-solarized ~/.dircolors-solarized
ln -sf ~/develify/dotfiles/.vimrc ~/.vimrc
ln -sf ~/develify/dotfiles/.tmux.conf ~/.tmux.conf

## install starship
bash $SCRIPT_DIR/../common/sh/install_starship.sh

## install exa
if [[ $(command -v exa) ]]; then
    echo "exa is already installed."
else
    echo "install exa"
    wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
    sudo unzip exa-linux-x86_64-v0.10.0.zip -d ~/exa
    sudo mv ~/exa/bin/exa /usr/local/bin/exa
    rm -rf ~/exa
fi

if [ -e "$HOME/.anyenv" ]; then
    echo "anyenv is already installed."
else
    git clone https://github.com/anyenv/anyenv ~/.anyenv
fi

source ~/.bash_profile