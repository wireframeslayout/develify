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

## eza / exa alias (exa は EOL のため eza を優先)
__develify_ls_cmd=""
if command -v eza >/dev/null 2>&1; then
    __develify_ls_cmd=eza
elif command -v exa >/dev/null 2>&1; then
    __develify_ls_cmd=exa
fi
if [ -n "$__develify_ls_cmd" ]; then
    alias ls="$__develify_ls_cmd --icons"
    alias ll="$__develify_ls_cmd --icons -la"
    alias l1="$__develify_ls_cmd -1"
    alias lt="$__develify_ls_cmd -Ta --icons -I 'node_modules|.git|.cache|vendor|tmp'"
    alias ltl='lt | less -r'
else
    alias ll='ls -la'
    alias l1='ls -1'
    alias lt='tree -I "node_modules|.git|.cache|vendor|tmp"'
    alias ltl='lt | less -r'
fi
unset __develify_ls_cmd
