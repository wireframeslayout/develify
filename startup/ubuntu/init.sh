#!/bin/bash

echo "Develify Ubuntu install Start."

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## synbolic links
ln -sf ~/develify/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/develify/dotfiles/.bashrc_ubuntu ~/.bashrc
ln -sf ~/develify/dotfiles/.dircolors-solarized ~/.dircolors-solarized
ln -sf ~/develify/dotfiles/.vimrc ~/.vimrc
ln -sf ~/develify/dotfiles/.tmux.conf ~/.tmux.conf

## install starship
bash $SCRIPT_DIR/../common/sh/install_starship.sh
bash $SCRIPT_DIR/../common/sh/install_starship_font_linux.sh

## install exa
if ![[ $(command -v exa) ]]; then
    echo "install exa"
    wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
    sudo unzip exa-linux-x86_64-v0.10.0.zip -d ~/exa
    sudo mv ~/exa/bin/exa /usr/local/bin/exa
    rm -rf ~/exa
else
    echo "exa is already installed."
fi

if ![ -e "$HOME/.anyenv" ]; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
else
    echo "anyenv is already installed."
fi

source ~/.bash_profile