#!/bin/bash
# Install eza (exa の後継。exa は 2023 年にアーカイブされ、Homebrew からも削除済)。
# https://github.com/eza-community/eza

set -euo pipefail

if command -v eza >/dev/null 2>&1; then
    echo "eza is already installed: $(command -v eza)"
    exit 0
fi

if command -v exa >/dev/null 2>&1; then
    echo "exa is already installed (legacy). 新規環境では eza が推奨されます: $(command -v exa)"
    exit 0
fi

echo "Install eza..."

case "${1:-}" in
    mac)
        if command -v brew >/dev/null 2>&1; then
            brew install eza
        else
            echo "Error: Homebrew が見つかりません。"
            exit 1
        fi
        ;;
    *)
        if command -v apt-get >/dev/null 2>&1; then
            ## eza は Ubuntu 24.04+ で apt にあるが、無ければ gpg リポジトリを足す
            if ! sudo apt-get install -y eza 2>/dev/null; then
                sudo mkdir -p /etc/apt/keyrings
                curl -fsSL https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
                    | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
                echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
                    | sudo tee /etc/apt/sources.list.d/gierens.list
                sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
                sudo apt-get update
                sudo apt-get install -y eza
            fi
        else
            ## fallback: GitHub release から ~/bin に展開
            EZA_VERSION="v0.20.13"
            TMP_DIR="$(mktemp -d)"
            trap 'rm -rf "$TMP_DIR"' EXIT
            curl -fL --retry 3 -o "$TMP_DIR/eza.tar.gz" \
                "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz"
            tar -xzf "$TMP_DIR/eza.tar.gz" -C "$TMP_DIR"
            mkdir -p "$HOME/bin"
            mv "$TMP_DIR/eza" "$HOME/bin/eza"
            chmod +x "$HOME/bin/eza"
        fi
        ;;
esac

echo "Install eza Done!"
