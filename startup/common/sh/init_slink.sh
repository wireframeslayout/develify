#!/bin/bash
# シンボリックリンクを作成する。
# 引数で platform を渡す: mac / wsl / その他は ubuntu 扱い

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"

case "${1:-ubuntu}" in
    mac) SCRIPTNAME=".bashrc_mac" ;;
    wsl) SCRIPTNAME=".bashrc_wsl" ;;
    *)   SCRIPTNAME=".bashrc_ubuntu" ;;
esac

## change permission (only shell scripts)
find "$ROOT_DIR/dotfiles" -name '*.sh' -exec chmod +x {} +

mkdir -p "$HOME/bin"

## synbolic links
ln -nsf "$ROOT_DIR/dotfiles/conf"                    "$HOME/conf.d"
ln -sf  "$ROOT_DIR/dotfiles/scripts/$SCRIPTNAME"     "$HOME/.bashrc"
ln -nsf "$ROOT_DIR/dotfiles/.dircolors-solarized"    "$HOME/.dircolors-solarized"
ln -sf  "$ROOT_DIR/dotfiles/.vimrc"                  "$HOME/.vimrc"
ln -sf  "$ROOT_DIR/dotfiles/.tmux.conf"              "$HOME/.tmux.conf"
ln -nsf "$ROOT_DIR/dotfiles/tmux-powerline"          "$HOME/.tmux-powerline"
ln -nsf "$ROOT_DIR/dotfiles/ohmyposh"                "$HOME/.ohmyposhconf"
ln -nsf "$ROOT_DIR/starship"                         "$HOME/.starshipconf"
ln -sf  "$ROOT_DIR/dotfiles/scripts/develify.sh"     "$HOME/bin/develify"

## WSL: clip-copy (UTF-8対応クリップボードコピー)
if [ "${1:-}" = "wsl" ]; then
    ln -sf "$ROOT_DIR/dotfiles/scripts/clip-copy.sh" "$HOME/bin/clip-copy"
fi
