#!/bin/zsh
# macOS 用 (zsh) セットアップエントリーポイント。

set -euo pipefail

echo "Mac (zsh) Install Start."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

## install homebrew (starship / oh-my-posh の前に必須)
bash "$SCRIPT_DIR/install_homebrew.sh"

## brew が現セッションにまだ無い場合は PATH に通す
if ! command -v brew >/dev/null 2>&1; then
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

## init synbolic link
bash "$SCRIPT_DIR/../common/zsh/init_slink.zsh" mac

## install starship
bash "$SCRIPT_DIR/../common/sh/install_starship.sh"

## install oh-my-posh
bash "$SCRIPT_DIR/../common/sh/install_ohmyposh.sh"

## install anyenv
bash "$SCRIPT_DIR/../common/sh/install_anyenv.sh"

## install exa
bash "$SCRIPT_DIR/../common/sh/install_exa.sh" mac

## install tpm (tmux plugin manager)
bash "$SCRIPT_DIR/../common/sh/install_tpm.sh"

## install neobundle
bash "$SCRIPT_DIR/../common/vim/install_neobundle.sh"

echo ""
echo "Mac (zsh) Install Done!"
echo "新しいターミナルを開くか、'source ~/.zshrc' を実行してください。"
