#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export DESKTOP_SESSION=LXDE
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
