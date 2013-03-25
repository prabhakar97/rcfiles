#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
PS1='[\u@\h \W]\$ '
alias hls='bin/hadoop fs -ls'
alias hrm='bin/hadoop fs -rm'
alias hrmr='bin/hadoop fs -rmr'
alias hmkdir='bin/hadoop fs -mkdir'
alias hmv='bin/hadoop fs -mv'
alias hnnf='bin/hadoop namenode -format'
alias hstop='bin/stop-all.sh'
alias hstart='bin/start-all.sh'
alias hput='bin/hadoop fs -put'
alias hget='bin/hadoop fs -get'
alias hrun='bin/hadoop jar'
