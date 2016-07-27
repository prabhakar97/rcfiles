# Include the necessary stuff
autoload -U compinit promptinit colors
compinit
promptinit
colors
export PS1="%# "

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _approximate 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s' 
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*' 
zstyle ':completion:*' menu select=long 
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s' 
zstyle ':completion:*' use-compctl true 
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Setup some exports
export EDITOR=vim
export HISTFILE=~/.history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
export GIT_SSH=/usr/bin/ssh

# Set some good options
setopt completealiases
setopt COMPLETE_IN_WORD
setopt auto_cd
setopt autopushd
setopt correct_all
setopt extendedglob
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Setup git friendly prompt
autoload -Uz vcs_info
zstyle ':vcs_info:git*' formats "%{$fg[green]%}%s:%{$reset_color%}%{$fg[yellow]%}%b%a%m%u%c%{$reset_color%} "
precmd() {
    vcs_info
}
setopt prompt_subst
PROMPT='${vcs_info_msg_0_}%# '
RPROMPT='%{$fg[green]%}%~%{$reset_color%}'

# Setup some key bindings
bindkey -e    # Emacs bindings are saner here
bindkey '^R' history-incremental-search-backward
bindkey "^[[A" history-search-backward    # Typing echo and pressing up key will show prev cmd starting with echo
bindkey "^[[B" history-search-forward
bindkey "^T" push-line-or-edit

# Setup some aliases
alias ll='ls -l'
alias lh='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias tmux='tmux -2'

# Some cool functions
# Climb n directories up
u () {
    set -A ud
    ud[1+${1-1}]=
    cd ${(j:../:)ud}
}

# Find a file below the current tree
findbelow () {
    find ./ -regex ".*/$1.*"
}

# This function copies all necessary stuff from my local system to a remote host
ssh_setup () {
  test -z $1 && echo "Hostname not passed" && exit 1
  # Files
  files=".amznzshrc .gemrc .gitconfig .gitignore .tmux.conf .vimrc .zshrc"
  directories=".vim"
  items="$files $directories"
  for file in $files; do
    test -e ~/$file && echo "Copying $file to $1" && scp -r ~/$file $1:~/
  done
}

# Setup rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Mac specific
[ `uname -s` = "Darwin" ] && export PATH=/usr/local/bin:$PATH     # Prefer brew apps over native apple
[ `uname -s` = "Darwin" ] && export JAVA_HOME=$(/usr/libexec/java_home)   # Fix JAVA_HOME

# AMZN specific
test -e ~/.amznzshrc && source ~/.amznzshrc

