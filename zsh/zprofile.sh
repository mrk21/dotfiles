# env
[ -n "${TERM_SESSION_ID}" ] && export IS_MAC_ENV=1
[ -n "${WSL_INTEROP}" ] && export IS_WSL_ENV=1

# base
export PATH=/usr/local/bin:${PATH}

# include sub settings
for config in $(find ~/.zprofile.d/ -name "*.sh"); do
  source $config;
done

# include local setting
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
