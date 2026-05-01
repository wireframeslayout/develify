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
${DIM}  Prefix = Ctrl-a${RESET}

${CYAN}  ── シェルコマンド ──${RESET}
${YELLOW}  tmux${RESET}                    新規セッション開始
${YELLOW}  tmux new -s ${DIM}<name>${RESET}       名前付きセッション作成
${YELLOW}  tmux ls${RESET}                  セッション一覧
${YELLOW}  tmux a${RESET}                   最後のセッションにアタッチ
${YELLOW}  tmux a -t ${DIM}<name>${RESET}         指定セッションにアタッチ
${YELLOW}  tmux kill-session -t ${DIM}<name>${RESET}  セッション削除
${YELLOW}  tmux kill-server${RESET}         全セッション終了

${CYAN}  ── 基本操作 ──${RESET}
${YELLOW}  Prefix + r${RESET}          設定リロード
${YELLOW}  Prefix + ?${RESET}          キーバインド一覧表示
${YELLOW}  Prefix + d${RESET}          セッションからデタッチ
${YELLOW}  Prefix + s${RESET}          セッション一覧 (選択切替)
${YELLOW}  Prefix + \$${RESET}          セッション名変更

${CYAN}  ── ペイン操作 ──${RESET}
${YELLOW}  Prefix + |${RESET}          縦分割 (カレントパス引き継ぎ)
${YELLOW}  Prefix + -${RESET}          横分割 (カレントパス引き継ぎ)
${YELLOW}  Prefix + h j k l${RESET}    ペイン移動 (←↓↑→)
${YELLOW}  Prefix + H J K L${RESET}    ペインリサイズ (連打可)
${GREEN}  Ctrl + o${RESET}             ペインローテーション ${DIM}(Prefix 不要)${RESET}
${YELLOW}  Prefix + z${RESET}          ペインのズーム (トグル)
${YELLOW}  Prefix + x${RESET}          ペインを閉じる

${CYAN}  ── ウィンドウ操作 ──${RESET}
${YELLOW}  Prefix + c${RESET}          新規ウィンドウ作成
${YELLOW}  Prefix + ,${RESET}          ウィンドウ名変更
${YELLOW}  Prefix + w${RESET}          ウィンドウ一覧 (選択切替)
${YELLOW}  Prefix + 0-9${RESET}        番号でウィンドウ切替
${YELLOW}  Prefix + Ctrl-h${RESET}     前のウィンドウ (連打可)
${YELLOW}  Prefix + Ctrl-l${RESET}     次のウィンドウ (連打可)
${YELLOW}  Prefix + &${RESET}          ウィンドウを閉じる

${CYAN}  ── コピーモード ──${RESET}
${YELLOW}  Prefix + [${RESET}          コピーモード開始
${DIM}  q${RESET}                    コピーモード終了
${DIM}  / ? ${RESET}                 検索 (前方 / 後方)
${DIM}  n N${RESET}                  次 / 前の検索結果
${DIM}  Space${RESET}                選択開始
${DIM}  Enter${RESET}                選択コピー ${DIM}(tmux-yank でクリップボードへ)${RESET}
${YELLOW}  Prefix + ]${RESET}          ペースト

${CYAN}  ── セッション保存・復元 ──${RESET}
${YELLOW}  Prefix + Ctrl-s${RESET}     セッション保存 ${DIM}(tmux-resurrect)${RESET}
${YELLOW}  Prefix + Ctrl-r${RESET}     セッション復元 ${DIM}(tmux-resurrect)${RESET}
${DIM}  ※ tmux-continuum により自動保存・復元も有効${RESET}

${CYAN}  ── ステータスバー ──${RESET}
${YELLOW}  Prefix + a${RESET}          左ステータス ミュート/アンミュート
${YELLOW}  Prefix + b${RESET}          右ステータス ミュート/アンミュート

${CYAN}  ── プラグイン管理 (TPM) ──${RESET}
${YELLOW}  Prefix + I${RESET}          プラグインインストール
${YELLOW}  Prefix + U${RESET}          プラグインアップデート

${CYAN}  ── インストール済みプラグイン ──${RESET}
${GREEN}  tpm${RESET}               プラグインマネージャ
${GREEN}  tmux-sensible${RESET}     万人向けデフォルト設定
${GREEN}  tmux-resurrect${RESET}    セッション保存・復元 (Prefix + Ctrl-s/r)
${GREEN}  tmux-continuum${RESET}    セッション自動保存・自動復元
${GREEN}  tmux-yank${RESET}         コピーモードの選択をクリップボードに自動コピー
${GREEN}  tmux-powerline${RESET}    Powerline スタイルのステータスバー

${CYAN}  ── 基本設定 ──${RESET}
${DIM}  ターミナル        tmux-256color + True Color
  マウス操作        有効
  ウィンドウ番号    1 から開始
  スクロールバック  50,000 行
  ステータスバー    上部表示${RESET}

EOF
