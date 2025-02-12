lfcd () {
    cd "$(command lf -print-last-dir "$@")"
}
bindkey -s '^O' 'lfcd\n'
