ff () {
  SEL="$(find $HOME/Documents/ -maxdepth 4 -type d | fzf)"
  [ -d $SEL ] && cd $SEL 
}
