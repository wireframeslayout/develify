#!/bin/bash
# macOS 用 (bash) セットアップエントリーポイント。

set -euo pipefail

echo "Mac (bash) Install Start."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

## parse options
WITH_GOTTY=false
for arg in "$@"; do
    case "$arg" in
        --with-gotty) WITH_GOTTY=true ;;
    esac
done

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
bash "$SCRIPT_DIR/../common/sh/init_slink.sh" mac

## install starship
bash "$SCRIPT_DIR/../common/sh/install_starship.sh"

## install oh-my-posh
bash "$SCRIPT_DIR/../common/sh/install_ohmyposh.sh"

## install anyenv
bash "$SCRIPT_DIR/../common/sh/install_anyenv.sh"

## install eza (exa の後継)
bash "$SCRIPT_DIR/../common/sh/install_eza.sh" mac

## install tpm (tmux plugin manager)
bash "$SCRIPT_DIR/../common/sh/install_tpm.sh"

## install neobundle
bash "$SCRIPT_DIR/../common/vim/install_neobundle.sh"

## install gotty (optional)
if $WITH_GOTTY; then
    bash "$SCRIPT_DIR/../common/sh/install_gotty.sh"
fi

echo ""
echo "Mac (bash) Install Done!"
echo "新しいターミナルを開くか、'source ~/.bashrc' を実行してください。"
