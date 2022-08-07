## anyenv
if [ -e "$HOME/.anyenv" ]
then
    export ANYENV_ROOT="$HOME/.anyenv"
    export PATH="$ANYENV_ROOT/bin:$PATH"
    if command -v anyenv 1>/dev/null 2>&1
    then
        eval "$(anyenv init -)"
    fi
fi

eval `dircolors ~/.dircolors-solarized/dircolors.256dark`

## exa alias
if [[ $(command -v exa) ]]; then
  alias ls='exa --icons'
  alias ll='exa --icons -la'
  alias l1='exa -1'
  alias lt='exa -Ta --icons -I "node_modules|.git|.cache|vendor|tmp"'
  alias ltl='lt | less -r'
else
  alias ll='ls -la'
  alias l1='ls -1'
  alias lt='tree -I "node_modules|.git|.cache|vendor|tmp"'
  alias ltl='lt | less -r'
fi

export STARSHIP_CONFIG=~/.starshipconf/starship.toml