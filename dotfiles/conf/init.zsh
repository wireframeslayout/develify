## anyenv
if [ -e "$HOME/.anyenv" ]; then
    export ANYENV_ROOT="$HOME/.anyenv"
    export PATH="$ANYENV_ROOT/bin:$PATH"
    if command -v anyenv 1>/dev/null 2>&1; then
        eval "$(anyenv init - zsh)"
    fi
fi

## ~/bin (oh-my-posh, prompt-switch etc.)
export PATH="$HOME/bin:$PATH"

## dircolors (GNU coreutils 経由でのみ利用可能)
if command -v gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors ~/.dircolors-solarized/dircolors.256dark)"
elif command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors ~/.dircolors-solarized/dircolors.256dark)"
fi

## eza (exa の後継) alias
## exa は上流アーカイブ済みのため eza を優先。既存環境の exa もフォールバックで許容する。
EZA_BIN=""
if command -v eza >/dev/null 2>&1; then
    EZA_BIN=eza
elif command -v exa >/dev/null 2>&1; then
    EZA_BIN=exa
fi
if [ -n "$EZA_BIN" ]; then
    alias ls="$EZA_BIN --icons"
    alias ll="$EZA_BIN --icons -la"
    alias l1="$EZA_BIN -1"
    alias lt="$EZA_BIN -Ta --icons -I \"node_modules|.git|.cache|vendor|tmp\""
    alias ltl='lt | less -r'
else
    alias ll='ls -la'
    alias l1='ls -1'
    alias lt='tree -I "node_modules|.git|.cache|vendor|tmp"'
    alias ltl='lt | less -r'
fi
unset EZA_BIN
