# AMZN specific
source /apollo/env/envImprovement/var/zshrc

# Include the necessary stuff
autoload -U compinit promptinit colors
compinit
promptinit
colors

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

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

# I am a vimmer
bindkey -v

# Don't need to type cd to get inside a dir
setopt auto_cd

# Push the entered dir onto stack
setopt autopushd

# Push current command on stack and give blank line, after that line runs, pop command stack
bindkey "^T" push-line-or-edit

# Climb n directories up
u () {
    set -A ud
    ud[1+${1-1}]=
    cd ${(j:../:)ud}
}

alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -A'
alias l='ls -CF'

# Source AMZN specific stuff
source ~/.amznzshrc
