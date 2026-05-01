#!/bin/bash

## install gotty (web-based terminal emulator)
echo "Install gotty..."

SCRIPT_DIR=$(cd $(dirname $0); pwd)
GOTTY_VERSION="v1.5.0"

if [[ $(command -v gotty) ]]; then
    echo "gotty is already installed."
else
    echo "Downloading gotty ${GOTTY_VERSION}..."
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)  GOTTY_ARCH="amd64" ;;
        aarch64) GOTTY_ARCH="arm64" ;;
        armv7l)  GOTTY_ARCH="arm" ;;
        *)
            echo "Error: Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac

    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    GOTTY_URL="https://github.com/sorenisanerd/gotty/releases/download/${GOTTY_VERSION}/gotty_${GOTTY_VERSION}_${OS}_${GOTTY_ARCH}.tar.gz"

    TMPDIR=$(mktemp -d)
    curl -sL "$GOTTY_URL" -o "$TMPDIR/gotty.tar.gz"
    tar xzf "$TMPDIR/gotty.tar.gz" -C "$TMPDIR"
    mkdir -p ~/bin
    mv "$TMPDIR/gotty" ~/bin/gotty
    chmod +x ~/bin/gotty
    rm -rf "$TMPDIR"

    echo "gotty installed to ~/bin/gotty"
fi

## setup config files
ln -sf "$SCRIPT_DIR/../../../dotfiles/gotty/.gotty" ~/.gotty
mkdir -p ~/.gotty.d
ln -sf "$SCRIPT_DIR/../../../dotfiles/gotty/index.html" ~/.gotty.d/index.html

echo "Install gotty Done!"
