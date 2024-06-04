#!/bin/bash
# Start some applications that run in the background.

# Hotkey Daemon
sxhkd &

# Background
~/.fehbg &

# DPI
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Compositor
picom -f &

# Statusbar
slstatus &

# Night Light
redshift -l "28.3974:84.1258" &

# Emacs Daemon
emacs --daemon &

# Notification Daemon
dunst &

# Start mpd if a process isn't already started.
[[ $(ps aux) =~ "mpd" ]] || mpd

# Key Remaps
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# Start dwm
exec dwm
