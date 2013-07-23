autoload -U compinit promptinit
compinit
promptinit
autoload -U colors && colors 
# This will set the default prompt to the walters theme
prompt walters
export PS1="%# "
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _approximate 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s' 
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*' 
zstyle ':completion:*' menu select=long 
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s' 
zstyle ':completion:*' use-compctl true 

setopt completealiases
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh
bindkey -e

setopt COMPLETE_IN_WORD
u ()  {
	set -A ud
	ud[1+${1-1}]=
	cd ${(j:../:)ud}
}
setopt auto_cd
setopt autopushd

#AWESOME...
# pushes current command on command stack and gives blank line, after that line runs, command stack is popped
bindkey "^T" push-line-or-edit

alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
