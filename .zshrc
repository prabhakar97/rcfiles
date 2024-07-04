# Include the necessary stuff
FPATH=~/.rbenv/completions:"$FPATH"
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

# For command editing emacs bindings are better
bindkey -e

# Don't need to type cd to get inside a dir
setopt auto_cd

# Push the entered dir onto stack
setopt autopushd

# Push current command on stack and give blank line, after that line runs, pop command stack
bindkey "^T" push-line-or-edit

# History config
export HISTSIZE=50000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_space
setopt hist_ignore_all_dups

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Climb n directories up
u () {
    set -A ud
    ud[1+${1-1}]=
    cd ${(j:../:)ud}
}

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias android_fs='aft-mtp-mount ~/LG'

findbelow () {
    find ./ -regex ".*/$1.*"
}
export VIMHOME=$HOME/.vim
export TERM="screen-256color"
export PATH="$HOME/.rbenv/bin:$PATH"                                                                                                                                    
eval "$(rbenv init -)"
export PATH=$PATH:/usr/local/go/bin

fzf-open-file-or-dir() {
  local cmd="command find -L . \
    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
  local out=$(eval $cmd | fzf-tmux --exit-0)

  if [ -f "$out" ]; then
    $EDITOR "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}
zle     -N   fzf-open-file-or-dir
# Ctrl+P starts fzf
bindkey '^P' fzf-open-file-or-dir
