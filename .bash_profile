#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ ${PATH} =~ /home/manish/.local/bin/ ]] || export PATH="/home/manish/.local/bin:$PATH"
[[ $(tty) = "/dev/tty1" ]] && startx
