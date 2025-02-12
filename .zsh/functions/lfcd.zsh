lfcd () {
    cd "$(command lf -print-last-dir "$@")"
}
bindkey -s '^o' 'lfcd\n'
