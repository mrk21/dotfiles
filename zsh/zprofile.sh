export PATH=/usr/local/bin:${PATH}

# include sub settings
for config in $(find ~/.zprofile.d/ -name "*.sh"); do
  source $config;
done

# include local setting
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
