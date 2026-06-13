#!/bin/bash
# init_prompt.bash - Initialize prompt engine (starship or oh-my-posh) for bash
# Sourced from .bashrc_* files

PROMPT_ENGINE_FILE="$HOME/.prompt_engine"

# Default: starship
PROMPT_ENGINE="starship"
PROMPT_THEME=""

# Load state file if exists
if [[ -f "$PROMPT_ENGINE_FILE" ]]; then
    source "$PROMPT_ENGINE_FILE"
fi

# oh-my-posh の bash 用 init は bash 4.2+ 機能 ([[ -v VAR ]] など) を使う。
# macOS 標準 bash 3.2 では構文エラーになるため、starship にフォールバックする。
if [[ "$PROMPT_ENGINE" == "ohmyposh" ]]; then
    if [[ -z "${BASH_VERSINFO[0]:-}" ]] || (( BASH_VERSINFO[0] < 4 )); then
        echo "[develify] WARNING: oh-my-posh は bash >= 4.2 を要求しますが、現在の bash は ${BASH_VERSION:-unknown} です。" >&2
        echo "[develify] starship にフォールバックします。新しい bash を使うには 'brew install bash' してから chsh してください。" >&2
        PROMPT_ENGINE="starship"
        # テーマ名はエンジンごとに異なるため、フォールバック時はデフォルトに戻す
        PROMPT_THEME=""
    fi
fi

case "$PROMPT_ENGINE" in
    starship)
        if command -v starship >/dev/null 2>&1; then
            if [[ -n "$PROMPT_THEME" ]]; then
                export STARSHIP_CONFIG="$HOME/.starshipconf/${PROMPT_THEME}.toml"
            else
                export STARSHIP_CONFIG="$HOME/.starshipconf/starship.toml"
            fi
            eval "$(starship init bash)"
        fi
        ;;
    ohmyposh)
        if command -v oh-my-posh >/dev/null 2>&1; then
            if [[ -n "$PROMPT_THEME" ]]; then
                # Local theme file takes priority, otherwise use built-in theme name
                LOCAL_THEME="$HOME/.ohmyposhconf/${PROMPT_THEME}.omp.json"
                if [[ -f "$LOCAL_THEME" ]]; then
                    eval "$(oh-my-posh init bash --config "$LOCAL_THEME")"
                else
                    eval "$(oh-my-posh init bash --config "$PROMPT_THEME")"
                fi
            else
                eval "$(oh-my-posh init bash --config "$HOME/.ohmyposhconf/develify.omp.json")"
            fi
        fi
        ;;
esac
