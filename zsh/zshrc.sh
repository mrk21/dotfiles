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

# color
autoload -U compinit
compinit

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

[ -n "${IS_MAC_ENV}" ] && alias ls="gls"
[ -n "${IS_MAC_ENV}" ] && alias code="open -b com.microsoft.vscode"
[ -n "${IS_WSL_ENV}" ] && alias open="wsl-open"
alias ls="ls --color"

# keymap
bindkey -v

# variables
export EDITOR=vim
export SHELL=/bin/zsh

# aliases
alias cp='cp -i'
alias gf="find . -not -regex '.*/\..*' -print0 | xargs -0 grep -E"
alias ha='history -E 1'
alias gh='history -E 1 | grep -E'
alias gp='ps ax | grep -E'
alias l='ls -F'
alias l.='ls -d .*'
alias la='ls -a'
alias ll='ls -l'
alias ll.='ls -l -d .*'
alias lla='ls -la'
alias mv='mv -i'
alias rm='rm -i'

alias docker_rmi_none="docker images -a | awk '/<none/{print \$3}' | xargs docker rmi -f"
alias docker_rm_all='docker rm $(docker ps -aq)'

# chpwd hook
chpwd(){
  set_git_local_config
}

# set git local config
# $ cat .git-local-config.sh
# git config user.name  'user name'
# git config user.email 'user@e.mail'
set_git_local_config(){
  local dir=$(pwd)
  
  # find .git directory
  while :; do
    local git=$dir/.git
    
    if [ -d $git ]; then
      export PREVIOUS_GIT_ROOT=$CURRENT_GIT_ROOT
      export CURRENT_GIT_ROOT=$git
      
      if [ "$CURRENT_GIT_ROOT" != "$PREVIOUS_GIT_ROOT" ]; then
        echo git repository: $(echo $(dirname $CURRENT_GIT_ROOT) | sed -e "s/$(cd ~; pwd|sed -e 's/\//\\\//g')/~/g")
      fi
      break
    elif [ $dir = '/' ]; then
      export CURRENT_GIT_ROOT=''
      export GIT_LOCAL_CONFIG=''
      return
    fi
    local dir=$(dirname $dir)
  done
  
  # find .git-local-config.sh
  while :; do
    local conf=$dir/.git-local-config.sh
    
    if [ -f $conf ]; then
      export GIT_LOCAL_CONFIG=$conf
      
      if [ "$CURRENT_GIT_ROOT" != "$PREVIOUS_GIT_ROOT" ]; then
        echo git local config: $(echo $GIT_LOCAL_CONFIG | sed -e "s/$(cd ~; pwd|sed -e 's/\//\\\//g')/~/g")
      fi
      break
    elif [ $dir = '/' ]; then
      export GIT_LOCAL_CONFIG=''
      return
    fi
    local dir=$(dirname $dir)
  done
  
  # apply local configs
  if git rev-parse 2> /dev/null; then
    source "$GIT_LOCAL_CONFIG" 2>/dev/null
  fi
}

# include sub settings
for config in $(find ~/.zshrc.d/ -name "*.sh"); do
  source $config;
done

# include local setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
