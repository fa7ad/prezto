#
# Defines Pacaur aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Aliases
#

# Disable color.
if ! zstyle -t ':prezto:module:pacman:pacaur' color; then
  alias pacman='pacaur --nocolor'
fi

# Manages .pac* files.
alias pacc='pacaur -C'
