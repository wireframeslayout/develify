#!/bin/bash
# Install starship prompt.
# Mac は brew を優先し、Linux は ~/bin にインストール (sudo 不要)。
# 設定ディレクトリ symlink (~/.starshipconf) は init_slink.sh 側で作成済みだが、
# 念のためここでも冪等に作る。

set -euo pipefail

echo "Install starship..."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"

if command -v starship >/dev/null 2>&1; then
    echo "starship is already installed: $(command -v starship)"
else
    case "$(uname -s)" in
        Darwin)
            if command -v brew >/dev/null 2>&1; then
                brew install starship
            else
                echo "Homebrew が見つからないため、~/bin にインストールします。"
                mkdir -p "$HOME/bin"
                curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/bin" --yes
            fi
            ;;
        *)
            mkdir -p "$HOME/bin"
            curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/bin" --yes
            ;;
    esac
fi

## conf symlink (冪等)
ln -nsf "$ROOT_DIR/starship" "$HOME/.starshipconf"

echo "Install starship Done!"
