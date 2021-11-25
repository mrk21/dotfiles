if which git > /dev/null; then
  # chpwd hook
  chpwd(){
    which git > /dev/null && set_git_local_config
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
fi
