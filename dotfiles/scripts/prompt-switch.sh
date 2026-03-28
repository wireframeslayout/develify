#!/bin/bash
# prompt-switch.sh - Switch between starship and oh-my-posh prompt engines
#
# Usage:
#   prompt-switch {starship|ohmyposh} [-t|--theme <theme_name>]
#
# Examples:
#   prompt-switch starship                    # starship + default (starship.toml)
#   prompt-switch starship -t tokyo-night     # starship + tokyo-night preset
#   prompt-switch ohmyposh                    # oh-my-posh + default (develify.omp.json)
#   prompt-switch ohmyposh -t night-owl       # oh-my-posh + built-in theme

set -euo pipefail

PROMPT_ENGINE_FILE="$HOME/.prompt_engine"

usage() {
    echo "Usage: prompt-switch {starship|ohmyposh} [-t|--theme <theme_name>]"
    echo ""
    echo "Arguments:"
    echo "  starship    Use starship as prompt engine"
    echo "  ohmyposh    Use oh-my-posh as prompt engine"
    echo ""
    echo "Options:"
    echo "  -t, --theme <name>  Theme name (default: built-in theme)"
    echo ""
    echo "Examples:"
    echo "  prompt-switch starship"
    echo "  prompt-switch starship -t tokyo-night"
    echo "  prompt-switch ohmyposh"
    echo "  prompt-switch ohmyposh -t night-owl"
    exit 1
}

# Parse arguments
if [[ $# -lt 1 ]]; then
    usage
fi

ENGINE="$1"
shift

THEME=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--theme)
            if [[ $# -lt 2 ]]; then
                echo "Error: --theme requires a value."
                exit 1
            fi
            THEME="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            ;;
    esac
done

# Validate engine
case "$ENGINE" in
    starship)
        if ! command -v starship &>/dev/null; then
            echo "Error: starship is not installed."
            echo "Install it with: curl -sS https://starship.rs/install.sh | sh"
            exit 1
        fi

        # Validate theme if specified
        if [[ -n "$THEME" ]]; then
            THEME_FILE="$HOME/.starshipconf/${THEME}.toml"
            if [[ ! -f "$THEME_FILE" ]]; then
                echo "Warning: Theme file '$THEME_FILE' not found."
                echo "You can create it with: starship preset $THEME -o $THEME_FILE"
                echo "Proceeding anyway (file may be created later)."
            fi
        fi
        ;;
    ohmyposh)
        if ! command -v oh-my-posh &>/dev/null; then
            echo "Error: oh-my-posh is not installed."
            echo "Install it with: curl -s https://ohmyposh.dev/install.sh | bash -s"
            exit 1
        fi

        # Validate theme if specified
        if [[ -n "$THEME" ]]; then
            LOCAL_THEME="$HOME/.ohmyposhconf/${THEME}.omp.json"
            if [[ -f "$LOCAL_THEME" ]]; then
                echo "Using local theme: $LOCAL_THEME"
            else
                echo "Using oh-my-posh built-in theme: $THEME"
            fi
        fi
        ;;
    *)
        echo "Error: Unknown engine '$ENGINE'. Use 'starship' or 'ohmyposh'."
        usage
        ;;
esac

# Write state file
cat > "$PROMPT_ENGINE_FILE" <<EOF
PROMPT_ENGINE="$ENGINE"
PROMPT_THEME="$THEME"
EOF

echo "Prompt engine switched to: $ENGINE"
if [[ -n "$THEME" ]]; then
    echo "Theme: $THEME"
else
    echo "Theme: default"
fi
echo ""
echo "Run 'source ~/.bashrc' or 'source ~/.zshrc' to apply."
