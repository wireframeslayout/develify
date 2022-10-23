#!/bin/bash

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## target
case $1 in
    "mac")
        SCRIPTNAME=".zshrc_mac";;
    "wsl")
        SCRIPTNAME=".zshrc_wsl";;
    *)
        SCRIPTNAME=".zshrc_ubuntu";;
esac

## change permission
chmod +x -R $SCRIPT_DIR/../../../dotfiles/

## synbolic links
ln -nsf $SCRIPT_DIR/../../../dotfiles/conf/ ~/conf.d
ln -sf $SCRIPT_DIR/../../../dotfiles/scripts/$SCRIPTNAME ~/.zshrc
ln -nsf $SCRIPT_DIR/../../../dotfiles/.dircolors-solarized/ ~/.dircolors-solarized
ln -sf $SCRIPT_DIR/../../../dotfiles/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/../../../dotfiles/.tmux.conf ~/.tmux.conf
ln -sf $SCRIPT_DIR/../../../dotfiles/.ideavimrc ~/.ideavimrc