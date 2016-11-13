###-begin-yarn-completion-###
if type compdef &>/dev/null; then
  _yarn_completion () {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" yarn completion -- "${words[@]}"))
    IFS=$si

    _describe 'values' reply
  }
  compdef _yarn_completion yarn
fi
###-end-yarn-completion-###

