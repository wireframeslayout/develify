#!/bin/bash
# gotty-install.sh - Install GoTTY web terminal with custom configuration
#
# Usage: develify gotty-install

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
GOTTY_VERSION="v1.5.0"

usage() {
    echo "Usage: develify gotty-install"
    echo ""
    echo "GoTTY (Web-based terminal emulator) をインストールし、"
    echo "JetBrainsMono Nerd Font 対応のカスタム設定を配置します。"
    echo ""
    echo "インストール内容:"
    echo "  ~/bin/gotty             GoTTY バイナリ (${GOTTY_VERSION})"
    echo "  ~/.gotty                設定ファイル (symlink)"
    echo "  ~/.gotty.d/index.html   カスタム HTML (symlink)"
    exit 0
}

case "${1:-}" in
    -h|--help|help) usage ;;
esac

echo "GoTTY ${GOTTY_VERSION} のインストールを開始します..."

## install binary
if command -v gotty &>/dev/null; then
    echo "gotty は既にインストールされています。($(gotty --version 2>&1))"
else
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  GOTTY_ARCH="amd64" ;;
        aarch64) GOTTY_ARCH="arm64" ;;
        armv7l)  GOTTY_ARCH="arm" ;;
        *)
            echo "Error: サポートされていないアーキテクチャ: $ARCH"
            exit 1
            ;;
    esac

    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    GOTTY_URL="https://github.com/sorenisanerd/gotty/releases/download/${GOTTY_VERSION}/gotty_${GOTTY_VERSION}_${OS}_${GOTTY_ARCH}.tar.gz"

    echo "ダウンロード中: $GOTTY_URL"
    TMPDIR=$(mktemp -d)
    curl -sL "$GOTTY_URL" -o "$TMPDIR/gotty.tar.gz"
    tar xzf "$TMPDIR/gotty.tar.gz" -C "$TMPDIR"
    mkdir -p ~/bin
    mv "$TMPDIR/gotty" ~/bin/gotty
    chmod +x ~/bin/gotty
    rm -rf "$TMPDIR"

    echo "gotty を ~/bin/gotty にインストールしました。"
fi

## setup config files
DOTFILES_GOTTY="$SCRIPT_DIR/../../dotfiles/gotty"
ln -sf "$DOTFILES_GOTTY/.gotty" ~/.gotty
mkdir -p ~/.gotty.d
ln -sf "$DOTFILES_GOTTY/index.html" ~/.gotty.d/index.html

echo ""
echo "セットアップ完了!"
echo "起動: develify gotty-start"
echo "      develify gotty-start -p 9000 -t <session>"
