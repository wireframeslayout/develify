#!/bin/bash
# Install JetBrainsMono Nerd Font on macOS.
# Homebrew Cask があれば font-jetbrains-mono-nerd-font を、なければ curl で
# ~/Library/Fonts に展開する。

set -euo pipefail

echo "Install JetBrainsMono Nerd Font..."

if command -v brew >/dev/null 2>&1; then
    brew install --cask font-jetbrains-mono-nerd-font
    echo "Font Install Done (via Homebrew Cask)!"
    exit 0
fi

FONT_VERSION="v3.2.1"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/JetBrainsMono.zip"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading $FONT_URL ..."
curl -fL --retry 3 -o "$TMP_DIR/JetBrainsMono.zip" "$FONT_URL"

mkdir -p "$HOME/Library/Fonts"
unzip -o "$TMP_DIR/JetBrainsMono.zip" -d "$HOME/Library/Fonts"

echo "Font Install Done!"
