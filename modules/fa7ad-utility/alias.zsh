# zshrc
alias zshrc="${EDITOR} ~/.zshrc"


# Reload
alias reloadpath='PATH=$PATH'
alias reloadzsh='source ~/.zshrc'


# VIm helpers
alias vim_install_packages='vim +BundleInstall! +BundleClean! +q!'
alias vim_clear_cache='rm -rf ~/.vim{backup,swap,undo,views} && echo -e "\033[0;32mDone!"'


# Made up Short-cuts
alias cls='clear'
alias sl='/usr/bin/env sl && l'


# Python3
alias python='python3'
alias pip3='sudo pip3'


# Obvious short hands
alias sshx='ssh -X'


# Open files
alias opn='xdg-open'
