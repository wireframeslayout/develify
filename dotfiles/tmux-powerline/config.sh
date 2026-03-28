#!/bin/bash
# tmux-powerline configuration
# See: https://github.com/erikw/tmux-powerline

# Nerd Font (JetBrainsMono) を使用
export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

# テーマ
export TMUX_POWERLINE_THEME="develify"

# カスタムテーマ・セグメントのパス
export TMUX_POWERLINE_DIR_USER_THEMES="$HOME/.tmux-powerline/themes"
export TMUX_POWERLINE_DIR_USER_SEGMENTS="$HOME/.tmux-powerline/segments"

# ステータスバーの更新間隔 (秒)
export TMUX_POWERLINE_STATUS_INTERVAL=1

# ステータスバーの表示
export TMUX_POWERLINE_STATUS_VISIBILITY="on"

# ステータスバーの配置
export TMUX_POWERLINE_STATUS_JUSTIFICATION="centre"

# ステータスバーの長さ
export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="90"

# Prefix + a でleft、Prefix + b でrightのpowerlineをミュート/アンミュート
export TMUX_POWERLINE_MUTE_LEFT_KEYBINDING="a"
export TMUX_POWERLINE_MUTE_RIGHT_KEYBINDING="b"

# デバッグモード (問題発生時に true にする)
export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
