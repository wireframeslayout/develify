# macOS Terminal.app / iTerm2 は bash を login shell として起動する。
# login shell は ~/.bashrc を読まないので、ここで明示的に source する。
[ -r ~/.bashrc ] && . ~/.bashrc
