#!/bin/zsh
# init_prompt.zsh - Initialize prompt engine (starship or oh-my-posh) for zsh
# Sourced from .zshrc_* files

PROMPT_ENGINE_FILE="$HOME/.prompt_engine"

# Default: starship
PROMPT_ENGINE="starship"
PROMPT_THEME=""

# Load state file if exists
if [[ -f "$PROMPT_ENGINE_FILE" ]]; then
    source "$PROMPT_ENGINE_FILE"
fi

case "$PROMPT_ENGINE" in
    starship)
        if command -v starship &>/dev/null; then
            if [[ -n "$PROMPT_THEME" ]]; then
                export STARSHIP_CONFIG="$HOME/.starshipconf/${PROMPT_THEME}.toml"
            else
                export STARSHIP_CONFIG="$HOME/.starshipconf/starship.toml"
            fi
            eval "$(starship init zsh)"
        fi
        ;;
    ohmyposh)
        if command -v oh-my-posh &>/dev/null; then
            if [[ -n "$PROMPT_THEME" ]]; then
                # Local theme file takes priority, otherwise use built-in theme name
                LOCAL_THEME="$HOME/.ohmyposhconf/${PROMPT_THEME}.omp.json"
                if [[ -f "$LOCAL_THEME" ]]; then
                    eval "$(oh-my-posh init zsh --config "$LOCAL_THEME")"
                else
                    eval "$(oh-my-posh init zsh --config "$PROMPT_THEME")"
                fi
            else
                eval "$(oh-my-posh init zsh --config "$HOME/.ohmyposhconf/develify.omp.json")"
            fi
        fi
        ;;
esac
