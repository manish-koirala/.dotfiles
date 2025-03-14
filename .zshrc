# History Configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=1500
SAVEHIST=6000

# Use the emacs keys
bindkey -e

# ZSH directory
export ZSH="$HOME/.zsh"

# Completions
autoload -Uz compinit && compinit 

# Custom Functions
source $ZSH/functions/ff.zsh
source $ZSH/functions/project.zsh
source $ZSH/functions/pyvenv.zsh
source $ZSH/functions/lfcd.zsh
source $ZSH/functions/acer-wmi.zsh
source $ZSH/functions/lenovo-batt.zsh

# Custom Plugins
source $ZSH/plugins/zsh-bat.plugin.zsh

# Arch-repo plugins
# pacman -S zsh-autosuggestions zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Custom Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias camera='mpv --demuxer-lavf-o=video_size=640x480 av://v4l2:/dev/video0 --profile=low-latency --untimed'
alias record-video='ffmpeg -f x11grab -i :0.0 $HOME/Videos/Recordings/$(date +%s).mkv'
alias vim='nvim'
alias vi='nvim'
alias dotf='git --work-tree=$HOME --git-dir=$HOME/.dotfiles'
alias bctl='bluetoothctl'
alias acer-battery-conserve='acer-toggle-battery-conservation-mode'
alias lenovo-battery-conserve='lenovo-toggle-battery-conservation-mode'
alias ll='ls --color=auto -lah'
alias neofetch='fastfetch'

# Prompt Configuration
PROMPT="%(?.%F{14}󰣇 .%F{9}󰣇 )%f %2~ %# "
source $ZSH/plugins/nice-prompt.zsh

# Run this command on start.
