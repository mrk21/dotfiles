# @see https://qiita.com/reireias/items/fd96d67ccf1fdffb24ed
if which peco > /dev/null; then
  # command search
  function peco-history-selection() {
    BUFFER=$(history -n 1 | tac | awk '!a[$0]++' | peco)
    CURSOR=$#BUFFER
    zle reset-prompt
  }
  zle -N peco-history-selection
  bindkey '^R' peco-history-selection

  # directory search
  function peco-cdr() {
    local selected_dir="$(cdr -l | sed -E 's/^[0-9]+ +//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
  }
  zle -N peco-cdr
  bindkey '^E' peco-cdr
fi
