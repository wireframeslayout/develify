#!/bin/bash
# gotty-start.sh - Launch GoTTY with develify custom configuration
#
# Usage:
#   develify gotty-start                         # tmux new session on port 8080
#   develify gotty-start -t <session>            # attach to existing tmux session
#   develify gotty-start -p <port>               # specify port
#   develify gotty-start -p <port> -t <session>  # both

set -euo pipefail

PORT="8080"
TMUX_SESSION=""
GOTTY_EXTRA_ARGS=()

usage() {
    cat <<EOF
Usage: develify gotty-start [options]

GoTTY を develify カスタム設定 (JetBrainsMono Nerd Font) で起動します。

Options:
  -p, --port <port>       ポート番号 (default: 8080)
  -t, --target <session>  アタッチする tmux セッション名
  -r, --readonly          読み取り専用モード (書き込み不可)
  -h, --help              このヘルプを表示

Examples:
  develify gotty-start                      # tmux new-session on :8080
  develify gotty-start -t main              # tmux attach -t main on :8080
  develify gotty-start -p 9000 -t main      # tmux attach -t main on :9000
  develify gotty-start -r -t main           # readonly mode
EOF
    exit 0
}

WRITABLE=true

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p|--port)
            if [[ $# -lt 2 ]]; then
                echo "Error: --port requires a value."
                exit 1
            fi
            PORT="$2"
            shift 2
            ;;
        -t|--target)
            if [[ $# -lt 2 ]]; then
                echo "Error: --target requires a value."
                exit 1
            fi
            TMUX_SESSION="$2"
            shift 2
            ;;
        -r|--readonly)
            WRITABLE=false
            shift
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            ;;
    esac
done

## check gotty is installed
if ! command -v gotty &>/dev/null; then
    echo "Error: gotty がインストールされていません。"
    echo "  develify gotty-install を実行してください。"
    exit 1
fi

## check custom index.html exists
INDEX_FILE="$HOME/.gotty.d/index.html"
if [[ ! -f "$INDEX_FILE" ]]; then
    echo "Error: カスタム index.html が見つかりません: $INDEX_FILE"
    echo "  develify gotty-install を実行してください。"
    exit 1
fi

## build gotty arguments
GOTTY_ARGS=(--index "$INDEX_FILE" --port "$PORT")

if $WRITABLE; then
    GOTTY_ARGS+=(-w)
fi

## build tmux command
if [[ -n "$TMUX_SESSION" ]]; then
    TMUX_CMD=(tmux a -t "$TMUX_SESSION")
else
    TMUX_CMD=(tmux)
fi

echo "GoTTY を起動します..."
echo "  URL:     http://localhost:${PORT}/"
echo "  tmux:    ${TMUX_CMD[*]}"
echo "  write:   ${WRITABLE}"
echo ""

exec gotty "${GOTTY_ARGS[@]}" "${TMUX_CMD[@]}"
