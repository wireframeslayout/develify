#!/bin/bash
# Install oh-my-posh prompt.
# Mac は brew を優先し、Linux/WSL は ~/bin にインストール (sudo 不要)。
# 設定ディレクトリ symlink (~/.ohmyposhconf) は init_slink.sh 側で作成済みだが、
# 念のためここでも冪等に作る。
# https://ohmyposh.dev/docs/installation/

set -euo pipefail

echo "Install oh-my-posh..."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"

if command -v oh-my-posh >/dev/null 2>&1; then
    echo "oh-my-posh is already installed: $(command -v oh-my-posh)"
else
    case "$(uname -s)" in
        Darwin)
            if command -v brew >/dev/null 2>&1; then
                brew install jandedobbeleer/oh-my-posh/oh-my-posh
            else
                echo "Homebrew が見つからないため、~/bin にインストールします。"
                mkdir -p "$HOME/bin"
                curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/bin"
            fi
            ;;
        *)
            mkdir -p "$HOME/bin"
            curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/bin"
            ;;
    esac
fi

## conf symlink (冪等)
ln -nsf "$ROOT_DIR/dotfiles/ohmyposh" "$HOME/.ohmyposhconf"

echo "Install oh-my-posh Done!"
