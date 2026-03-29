#!/bin/bash

echo "Termux Install Start."

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## update packages
pkg update && pkg upgrade -y

## install basic packages
pkg install -y git curl tmux vim zsh unzip

## init synbolic link
bash $SCRIPT_DIR/../common/sh/init_slink.sh termux

## install starship (pkg, not curl installer)
pkg install -y starship
ln -nsf $SCRIPT_DIR/../../starship/ ~/.starshipconf

## install oh-my-posh
bash $SCRIPT_DIR/../common/sh/install_ohmyposh.sh

## install anyenv
bash $SCRIPT_DIR/../common/sh/install_anyenv.sh

## install exa (pkg, x86_64 binary script is not compatible)
pkg install -y exa

## install tpm (tmux plugin manager)
bash $SCRIPT_DIR/../common/sh/install_tpm.sh

## install neobundle
bash $SCRIPT_DIR/../common/vim/install_neobundle.sh

## Nerd Font (optional): bash $SCRIPT_DIR/../common/sh/install_starship_font_termux.sh

source ~/.bashrc
