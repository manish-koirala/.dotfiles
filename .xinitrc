#!/bin/bash
# Environment
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH=$PATH:$HOME/.local/bin
export EDITOR=nvim
export PAGER=less

# Xresources
xrdb -merge -I$HOME/ .Xresources

# Start mpd (music player daemon)
# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd &

# picom
picom -f &

# Set the minimum brightness value.
brillo -c -S 10

# Background
$HOME/.fehbg &

# statusbar
dwmblocks &

# nightlight
redshift -l 28.39:84.12 &

# slock - Lock after 10 minutes of inactivity
xautolock -time 10 -locker slock &

# entr
# execute commands when some file changes.
# echo ~/.bashrc | entr notify-send "Bashrc file has changed."

# Run dwm
exec dwm
