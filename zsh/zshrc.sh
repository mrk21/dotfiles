# base
HISTFILE=$HOME/.zsh-history
HISTSIZE=0xFFFFFFF
SAVEHIST=0xFFFFFFF
setopt share_history
setopt AUTO_MENU
setopt AUTO_PUSHD
setopt CORRECT
setopt HIST_NO_STORE
setopt LIST_PACKED
setopt SHARE_HISTORY

PROMPT="%B%F{red}#%b%f "
RPROMPT="%B%F{yellow}[%n@%m:%~ ]%b%f"

case $TERM in
  xterm*)
    precmd () { print -Pn "\e]0;%~\a" }
    ;;
esac

# color
autoload -U compinit
compinit

# cdr
# @see https://qiita.com/reireias/items/fd96d67ccf1fdffb24ed
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# keymap
bindkey -v

# @see https://stackoverflow.com/questions/61466461/yank-in-visual-vim-mode-in-zsh-does-not-copy-to-clipboard-in-ordert-to-paste-w
if [ -n "${IS_MAC_ENV}" ]; then
  function vi-yank-xclip {
      zle vi-yank
    printf "$CUTBUFFER" | pbcopy -i
  }
  zle -N vi-yank-xclip
  bindkey -M vicmd 'y' vi-yank-xclip
fi

# variables
export EDITOR=vim
export SHELL=/bin/zsh

# aliases
if [ -n "${IS_MAC_ENV}" ]; then
  alias ls="gls"
  alias find="gfind"
  alias xargs="gxargs"
  alias sed="gsed"
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:${PATH}
elif [ -n "${IS_WSL_ENV}" ]; then
  alias open="wsl-open"
fi

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

# set PATH
export PATH=~/bin:${PATH}

# include sub settings
for config in $(find ~/.zshrc.d/ -name "*.sh"); do
  source $config;
done

# include local setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
