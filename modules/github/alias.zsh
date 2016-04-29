# aliases for github
if (( $+commands[hub] )); then
    alias ogit="/usr/bin/git"
    alias git="hub"
fi
alias gcr="git create"
alias gfo="git fork"
alias gpr="git pull-request"
alias ghbr="git browse"
alias gcmp="git compare"
alias gcis="git ci-status"
