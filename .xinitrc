#!/bin/bash
# Environment
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH=$PATH:$HOME/.local/bin
export EDITOR=nvim
export PAGER=less

# Xresources
xrdb -merge -I $HOME/.Xresources

# Start mpd (music player daemon)
# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd &

# Start dunst (notification daemon)
dunst &

# picom
picom -f &

# Background
$HOME/.fehbg &

# statusbar
slstatus &

# Emacs Daemon
emacs -nw --daemon &

# Keyboard Hotkey Daemon 
sxhkd &

# nightlight
redshift -l 28.39:84.12 &

# slock - Lock after 10 minutes of inactivity
xautolock -time 10 -locker slock &

# Run dwm
exec dwm
