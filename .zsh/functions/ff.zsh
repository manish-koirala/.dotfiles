ff () {
  SEL=$(find $HOME -maxdepth 8 -type d | grep -vP "/\.\w+" | fzf)
  [ -d $SEL ] && cd $SEL 
}

