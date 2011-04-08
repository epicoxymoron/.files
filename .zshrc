#!/bin/zsh

# editor settings
setopt vi
export EDITOR="vi"

# completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# prompt
autoload -U promptinit
promptinit

# history
export HISTSIZE=2000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_dups
setopt append_history
setopt inc_append_history
setopt share_history
setopt hist_reduce_blanks
setopt hist_verify
setopt extended_history

# fanciness
setopt autocd
setopt extendedglob
setopt auto_pushd
setopt no_beep

# and get the rest
autoload /usr/share/zsh/4.*/functions/*(:t)

uptime
