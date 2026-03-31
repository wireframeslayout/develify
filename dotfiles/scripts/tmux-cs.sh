#!/bin/bash
# tmux-cs.sh - tmux cheat sheet for develify
#
# Usage: develify tmux-cs

# Colors
BOLD=$'\033[1m'
CYAN=$'\033[36m'
YELLOW=$'\033[33m'
GREEN=$'\033[32m'
DIM=$'\033[2m'
RESET=$'\033[0m'

cat <<EOF

${BOLD}  tmux Cheat Sheet (develify)${RESET}
${DIM}  Prefix = Ctrl-b${RESET}

${CYAN}  ── 基本操作 ──${RESET}
${YELLOW}  Prefix + r${RESET}          設定リロード

${CYAN}  ── ペイン操作 ──${RESET}
${YELLOW}  Prefix + |${RESET}          縦分割 (カレントパス引き継ぎ)
${YELLOW}  Prefix + -${RESET}          横分割 (カレントパス引き継ぎ)
${YELLOW}  Prefix + h j k l${RESET}    ペイン移動 (←↓↑→)
${YELLOW}  Prefix + H J K L${RESET}    ペインリサイズ (連打可)
${GREEN}  Ctrl + o${RESET}             ペインローテーション ${DIM}(Prefix 不要)${RESET}

${CYAN}  ── ウィンドウ操作 ──${RESET}
${YELLOW}  Prefix + Ctrl-h${RESET}     前のウィンドウ (連打可)
${YELLOW}  Prefix + Ctrl-l${RESET}     次のウィンドウ (連打可)

${CYAN}  ── セッション管理 (tmux-resurrect) ──${RESET}
${YELLOW}  Prefix + Ctrl-s${RESET}     セッション保存
${YELLOW}  Prefix + Ctrl-r${RESET}     セッション復元
${DIM}  ※ tmux-continuum により自動保存・復元も有効${RESET}

${CYAN}  ── ステータスバー ──${RESET}
${YELLOW}  Prefix + a${RESET}          左ステータス ミュート/アンミュート
${YELLOW}  Prefix + b${RESET}          右ステータス ミュート/アンミュート

${CYAN}  ── プラグイン管理 ──${RESET}
${YELLOW}  Prefix + I${RESET}          プラグインインストール
${YELLOW}  Prefix + U${RESET}          プラグインアップデート

${CYAN}  ── 基本設定 ──${RESET}
${DIM}  ターミナル        tmux-256color + True Color
  マウス操作        有効
  ウィンドウ番号    1 から開始
  スクロールバック  50,000 行
  ステータスバー    上部表示${RESET}

EOF
