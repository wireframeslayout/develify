#!/bin/bash
# eza (exa の後継) をインストールする。
#
# exa は 2023 年に上流リポジトリ (ogham/exa) がアーカイブされ、
# Homebrew からも formula が削除された (`brew install exa` は No available formula)。
# 後継の maintained fork である eza は CLI 互換なので、
# develify の ls / ll / l1 / lt エイリアスはそのまま動作する。

set -uo pipefail

## GitHub リリースから入れる場合のバージョン (apt に無い古いディストリビューション向け)
EZA_VERSION="v0.23.5"

if command -v eza >/dev/null 2>&1; then
    echo "eza is already installed."
    exit 0
fi

echo "install eza"

case "${1:-}" in
    "mac")
        brew install eza
        ;;
    *)
        ## Ubuntu 24.04 / Debian 13 以降は apt に eza がある
        if apt-cache show eza >/dev/null 2>&1; then
            sudo apt-get update
            sudo apt-get install -y eza
        else
            ## それ以前は GitHub リリースのビルド済みバイナリを使う
            case "$(uname -m)" in
                x86_64)        EZA_ARCH="x86_64-unknown-linux-gnu" ;;
                aarch64|arm64) EZA_ARCH="aarch64-unknown-linux-gnu" ;;
                *)
                    echo "eza: unsupported architecture $(uname -m)" >&2
                    exit 0
                    ;;
            esac
            EZA_TMP="$(mktemp -d)"
            curl -fsSL -o "$EZA_TMP/eza.tar.gz" \
                "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_${EZA_ARCH}.tar.gz"
            tar -xzf "$EZA_TMP/eza.tar.gz" -C "$EZA_TMP"
            sudo install -m 755 "$EZA_TMP/eza" /usr/local/bin/eza
            rm -rf "$EZA_TMP"
        fi
        ;;
esac

if command -v eza >/dev/null 2>&1; then
    echo "eza installed."
else
    ## ここで失敗しても init.sh 全体は止めない (ls は素の ls にフォールバックする)
    echo "warning: eza install failed. ls/ll/lt fall back to plain ls / tree." >&2
fi
