# Authors:
# https://github.com/AlexBio
# https://github.com/dbb
# https://github.com/Mappleconfusers
# Nicolas Jonas nextgenthemes.com
# https://github.com/loctauxphilippe
#
# Debian, Ubuntu and friends related zsh aliases and functions for zsh

alias acs='apt-cache search'
compdef _acs acs='apt-cache search'

alias afs='apt-file search --regexp'
compdef _afs afs='apt-file search --regexp'

# These are aptitude only
alias ags='aptitude source'   # asrc
compdef _ags ags='aptitude source'

alias acp='apt-cache policy' # app
compdef _acp acp='apt-cache policy'

# superuser operations ######################################################
alias afu='sudo apt-file update'
compdef _afu afu='sudo apt-file update'

alias ppap='sudo ppa-purge'
compdef _ppap ppap='sudo ppa-purge'

alias ag='sudo aptitude'            # age - but without sudo
alias aga='sudo aptitude autoclean' # aac
alias agar='sudo apt-get autoremove'
alias agb='sudo aptitude build-dep' # abd
alias agc='sudo aptitude clean'     # adc
alias agd='sudo aptitude dselect-upgrade' # ads
alias agi='sudo aptitude install'  # ai
alias agp='sudo aptitude purge'    # ap
alias agr='sudo aptitude remove'   # ar
alias agu='sudo aptitude update'   # ad
alias agf='sudo aptitude full-upgrade'
alias agdf='sudo aptitude update && sudo aptitude full-upgrade' #adu
alias agug='sudo aptitude upgrade' # ag
alias aguu='sudo aptitude update && sudo aptitude upgrade'      #adg
alias agar='sudo apt-get autoremove'

compdef _ag ag='sudo aptitude'
compdef _aga aga='sudo aptitude autoclean'
compdef _agar agar='sudo apt-get autoremove'
compdef _agb agb='sudo aptitude build-dep'
compdef _agc agc='sudo aptitude clean'
compdef _agd agd='sudo aptitude dselect-upgrade'
compdef _agi agi='sudo aptitude install'
compdef _agp agp='sudo aptitude purge'
compdef _agr agr='sudo aptitude remove'
compdef _agu agu='sudo aptitude update'
compdef _agud agud='sudo aptitude update && sudo aptitude full-upgrade'
compdef _agug agug='sudo aptitude upgrade'
compdef _aguu aguu='sudo aptitude update && sudo aptitude upgrade'
compdef _agar agar='sudo apt-get autoremove'

# Remove ALL kernel images and headers EXCEPT the one in use
alias kclean='sudo aptitude remove -P ?and(~i~nlinux-(ima|hea) \
  ?not(~n`uname -r`))'

# Misc. #####################################################################
# print all installed packages
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

# Create a basic .deb package
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'

# apt-add-repository with automatic install/upgrade of the desired package
# Usage: aar ppa:xxxxxx/xxxxxx [packagename]
# If packagename is not given as 2nd argument the function will ask for it and guess the default by taking
# the part after the / from the ppa name wich is sometimes the right name for the package you want to install
function aar {
  if [ -n "$2" ]; then
    PACKAGE=$2
  else
    read "PACKAGE?Type in the package name to install/upgrade with this ppa [${1##*/}]: "
  fi

  if [ -z "$PACKAGE" ]; then
    PACKAGE=${1##*/}
  fi

  sudo apt-add-repository $1 && sudo aptitude update
  sudo aptitude install $PACKAGE
}

# Prints apt history
# Usage:
#   apt-history install
#   apt-history upgrade
#   apt-history remove
#   apt-history rollback
#   apt-history list
# Based On: http://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
function apt-history {
  case "$1" in
    install)
      zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
      ;;
    upgrade|remove)
      zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
      ;;
    rollback)
      zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    list)
      zcat $(ls -rt /var/log/dpkg*)
      ;;
    *)
      echo "Parameters:"
      echo " install - Lists all packages that have been installed."
      echo " upgrade - Lists all packages that have been upgraded."
      echo " remove - Lists all packages that have been removed."
      echo " rollback - Lists rollback information."
      echo " list - Lists all contains of dpkg logs."
      ;;
  esac
}

# Kernel-package building shortcut
function kerndeb {
  # temporarily unset MAKEFLAGS ( '-j3' will fail )
  MAKEFLAGS=$( print - $MAKEFLAGS | perl -pe 's/-j\s*[\d]+//g' )
  print '$MAKEFLAGS set to '"'$MAKEFLAGS'"
  appendage='-custom' # this shows up in $ (uname -r )
  revision=$(date +"%Y%m%d") # this shows up in the .deb file name

  make-kpkg clean

  time fakeroot make-kpkg --append-to-version "$appendage" --revision \
    "$revision" kernel_image kernel_headers
}

# List packages by size
function apt-list-packages {
  dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' | \
  grep -v deinstall | \
  sort -n | \
  awk '{print $1" "$2}'
}
