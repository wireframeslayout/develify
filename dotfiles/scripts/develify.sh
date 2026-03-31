#!/bin/bash
# develify - Develify CLI tool
#
# Usage: develify <command> [args...]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION="1.0.0"

usage() {
    cat <<EOF
develify v${VERSION} - 開発環境セットアップツール

Usage: develify <command> [options]

Commands:
  prompt-switch   プロンプトエンジンの切り替え (starship / oh-my-posh)
  tmux-cs         tmux キーバインド チートシート表示
  help            このヘルプを表示
  version         バージョン表示

Run 'develify <command> --help' for more information.
EOF
}

case "${1:-}" in
    prompt-switch)
        shift
        exec "$SCRIPT_DIR/prompt-switch.sh" "$@"
        ;;
    tmux-cs)
        shift
        exec "$SCRIPT_DIR/tmux-cs.sh" "$@"
        ;;
    help|--help|-h)
        usage
        ;;
    version|--version|-v)
        echo "develify v${VERSION}"
        ;;
    "")
        usage
        ;;
    *)
        echo "Error: Unknown command '$1'"
        echo ""
        usage
        exit 1
        ;;
esac
