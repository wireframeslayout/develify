#!/bin/bash
# zsh 用のシンボリックリンク作成スクリプト。
# bash で起動される (#! /bin/bash) ことを前提に書かれている。
# 引数で platform を渡す: mac / wsl / その他は ubuntu 扱い

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"

case "${1:-ubuntu}" in
    mac) SCRIPTNAME=".zshrc_mac" ;;
    wsl) SCRIPTNAME=".zshrc_wsl" ;;
    *)   SCRIPTNAME=".zshrc_ubuntu" ;;
esac

## change permission (BSD/GNU 互換シンタックス)
find "$ROOT_DIR/dotfiles" -name '*.sh' -exec chmod +x {} +

mkdir -p "$HOME/bin"

## synbolic links
ln -nsf "$ROOT_DIR/dotfiles/conf"                    "$HOME/conf.d"
ln -sf  "$ROOT_DIR/dotfiles/scripts/$SCRIPTNAME"     "$HOME/.zshrc"
ln -nsf "$ROOT_DIR/dotfiles/.dircolors-solarized"    "$HOME/.dircolors-solarized"
ln -sf  "$ROOT_DIR/dotfiles/.vimrc"                  "$HOME/.vimrc"
ln -sf  "$ROOT_DIR/dotfiles/.tmux.conf"              "$HOME/.tmux.conf"
ln -nsf "$ROOT_DIR/dotfiles/tmux-powerline"          "$HOME/.tmux-powerline"
ln -nsf "$ROOT_DIR/dotfiles/ohmyposh"                "$HOME/.ohmyposhconf"
ln -nsf "$ROOT_DIR/starship"                         "$HOME/.starshipconf"
ln -sf  "$ROOT_DIR/dotfiles/.ideavimrc"              "$HOME/.ideavimrc"
ln -sf  "$ROOT_DIR/dotfiles/scripts/develify.sh"     "$HOME/bin/develify"

## WSL: clip-copy
if [ "${1:-}" = "wsl" ]; then
    ln -sf "$ROOT_DIR/dotfiles/scripts/clip-copy.sh" "$HOME/bin/clip-copy"
fi
