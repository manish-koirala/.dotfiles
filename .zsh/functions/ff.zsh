ff () {
  SEL_DIRS=(
    "$HOME/.config/"
    "$HOME/.local/src/"
    "$HOME/.local/share/applications/"
    "$HOME/Documents/"
    "$HOME/.zsh/"
    "$HOME/.zshrc"
    "$HOME/.xinitrc"
    "$HOME/.Xresources"
    )

  # Gtab the selection
  if [[ $# -eq 1 && -n $1 ]] ; then
    SEL="$(find ${SEL_DIRS[*]} -maxdepth 5 -iname "*${1}*" | grep -vP '.venv|__pycache__|node_modules' | fzf)"
  else
    SEL="$(find ${SEL_DIRS[*]} -maxdepth 5 | grep -vP '.venv|__pycache__|node_modules' | fzf)"
  fi

  if [[ $SEL != "" && -f $SEL ]] ; then
    nvim $SEL
  elif [[ $SEL != "" && -d $SEL ]]; then
    cd $SEL 
  fi
}

