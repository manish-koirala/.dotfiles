ff () {
  SEL_DIRS=(
    "$HOME/.config/"
    "$HOME/.local/src/"
    "$HOME/.local/share/applications/"
    "$HOME/Documents/"
    "$HOME/.zsh/"
    "$HOME/.zshrc"
    "$HOME/.zprofile"
    "$HOME/.xinitrc"
    "$HOME/.Xresources"
    )
  SEL="$(find ${SEL_DIRS[*]} -maxdepth 5 | grep -vP '/.venv|/__pycache__/node_modules' | fzf)"
  if [[ $SEL != "" && -f $SEL ]] ; then
    nvim $SEL
  elif [[ $SEL != "" && -d $SEL ]]; then
    cd $SEL 
  fi
}

