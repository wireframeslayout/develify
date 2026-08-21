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

## ~/.bash_profile から ~/.bashrc を読み込ませる
##
## bash はログインシェルとして起動されると ~/.bashrc を読まず、
## ~/.bash_profile (無ければ ~/.bash_login → ~/.profile) だけを読む。
## macOS のターミナル (Terminal.app / iTerm2 / Ghostty) はいずれもシェルを
## ログインシェルとして起動するため、~/.bashrc へのリンクを張っただけでは
## develify の設定が一切適用されない。
##
## Ubuntu / WSL は既定で ~/.profile が ~/.bashrc を読む作りになっているので、
## ~/.bash_profile が存在する場合のみ対象にする
## (~/.bash_profile を新規に作ると bash が ~/.profile を読まなくなるため)。
##
## Homebrew や各種インストーラが書き込む内容を壊さないよう、
## シンボリックリンクではなく追記で行う。
BASH_PROFILE="$HOME/.bash_profile"
if [ "${1:-ubuntu}" = "mac" ] || [ -e "$BASH_PROFILE" ]; then
    if [ -e "$BASH_PROFILE" ] && grep -q '\.bashrc' "$BASH_PROFILE"; then
        echo "$BASH_PROFILE already loads ~/.bashrc."
    else
        cat >> "$BASH_PROFILE" <<'PROFILE'

# >>> develify >>>
# ログインシェルは ~/.bashrc を読まないため、ここから読み込む。
if [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi
# <<< develify <<<
PROFILE
        echo "added ~/.bashrc loader to $BASH_PROFILE"
    fi
fi
