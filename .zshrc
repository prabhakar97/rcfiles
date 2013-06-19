autoload -U compinit promptinit
compinit
promptinit
autoload -U colors && colors 
# This will set the default prompt to the walters theme
prompt walters
zstyle ':completion:*' menu select
setopt completealiases
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh
bindkey -e
