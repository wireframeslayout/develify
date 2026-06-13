#!/bin/bash
# Develify one-liner installer.
#
# プラットフォームを自動検出して startup/{mac,ubuntu,wsl}/init.sh に処理を委譲します。
#
# Usage:
#   bash install.sh                  # 自動検出
#   bash install.sh mac              # 明示
#   bash install.sh mac --with-gotty # 追加オプションは init.sh にそのまま渡す

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

## detect platform
detect_platform() {
    case "$(uname -s)" in
        Darwin)
            echo "mac"
            ;;
        Linux)
            if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
                echo "wsl"
            else
                echo "ubuntu"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

## first positional may be the platform
PLATFORM=""
case "${1:-}" in
    mac|ubuntu|wsl)
        PLATFORM="$1"
        shift
        ;;
esac

if [ -z "$PLATFORM" ]; then
    PLATFORM="$(detect_platform)"
fi

if [ "$PLATFORM" = "unknown" ]; then
    echo "Error: 対応プラットフォームを検出できませんでした。"
    echo "使い方: bash install.sh {mac|ubuntu|wsl} [options]"
    exit 1
fi

INIT_SCRIPT="$SCRIPT_DIR/startup/$PLATFORM/init.sh"
if [ ! -f "$INIT_SCRIPT" ]; then
    echo "Error: $INIT_SCRIPT が見つかりません。"
    exit 1
fi

echo "Develify installer: platform=$PLATFORM"
exec bash "$INIT_SCRIPT" "$@"
