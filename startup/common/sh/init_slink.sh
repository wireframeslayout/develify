#!/bin/bash

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## target
case $1 in
    "mac")
        SCRIPTNAME=".bashrc_mac";;
    "wsl")
        SCRIPTNAME=".bashrc_wsl";;
    *)
        SCRIPTNAME=".bashrc_ubuntu";;
esac

## change permission
chmod +x -R $SCRIPT_DIR/../../../dotfiles

## synbolic links
ln -nsf $SCRIPT_DIR/../../../dotfiles/conf/ ~/conf.d
ln -sf $SCRIPT_DIR/../../../dotfiles/scripts/$SCRIPTNAME ~/.bashrc
ln -nsf $SCRIPT_DIR/../../../dotfiles/.dircolors-solarized/ ~/.dircolors-solarized
ln -sf $SCRIPT_DIR/../../../dotfiles/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/../../../dotfiles/.tmux.conf ~/.tmux.conf
ln -nsf $SCRIPT_DIR/../../../dotfiles/tmux-powerline/ ~/.tmux-powerline
ln -nsf $SCRIPT_DIR/../../../dotfiles/ohmyposh/ ~/.ohmyposhconf
mkdir -p ~/bin
ln -sf $SCRIPT_DIR/../../../dotfiles/scripts/prompt-switch.sh ~/bin/prompt-switch