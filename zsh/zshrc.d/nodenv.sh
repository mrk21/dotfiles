export PATH="$HOME/.nodenv/bin:$PATH"

if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi
