# UTILITIES FUNCTION
# Launch the pyvenv function if .venv/ or requirements.txt is found in the current directory.
function autopyvenv () {
  [[ -d "./.venv/" || -f "./requirements.txt" ]] && pyvenv
}

# MAIN FUNCTION
# A function to quickly open tmux and set up my project.
project () {
  # Arguments
  [ $# -eq 1 ] && SESSION_NAME="$1" || SESSION_NAME="project"
  tmux has-session -t $SESSION_NAME 2> /dev/null # Find if the project session exists.
  if [ $? -eq 0 ] ; then # If the project session already exists.
    tmux attach-session -t $SESSION_NAME
  else
    SEL=$(find $HOME/Documents/Code/ -maxdepth 5 -type d | grep -vP "/\.\w+|/__pycache__|/node_modules" | fzf)

    if [[ "${SEL}" != "" &&  -d $SEL ]] ; then
      cd $SEL # Change into the directory
      tmux new-session -d -s $SESSION_NAME # Start a detached session known as "project"
      # Rename the first window and start neovim, also run the pyvenv script if .venv folder is detected.
      tmux rename-window -t 1 'Neovim'
      tmux send-keys -t 'Neovim' 'autopyvenv' C-m # Activate python virtual environment if python project detected.
      tmux send-keys -t 'Neovim' 'clear' C-m
      tmux send-keys -t 'Neovim' 'nvim' C-m

      # Create and setup window for zsh
      tmux new-window -t $SESSION_NAME:2 -n 'Shell'
      tmux send-keys -t 'Shell' 'autopyvenv' C-m # Activate python venv if python project detected
      tmux send-keys -t 'Shell' 'clear' C-m

      # Create and setup window for music
      tmux new-window -t $SESSION_NAME:3 -n 'Clock'
      tmux send-keys -t 'Clock' 'ncmpcpp' C-m
      tmux send-keys -t 'Clock' '='
      
      # Attach to the process
      tmux select-window -t 'Neovim'
      tmux send-keys -t 'Neovim' ':Telescope find_files' C-m
      tmux attach-session -t $SESSION_NAME

      # Restore user's previous cwd
      cd -
    fi
  fi
}
