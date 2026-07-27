#!/bin/bash

[[ $1 == "--help" || $1 == "-h" ]] && printf "You need \e[1mEUID 0\e[0m (current EUID: \e[0;91m$(echo $EUID)\e[0m) to run the installation script.\n\n" && printf "%-20s %0s\n%-20s %0s\n%-20s %0s\n" "--help" ":: show this message." "./install" ":: installs maya" "./install --remove" ":: remove maya" && exit

[[ $EUID != 0 ]] && printf "\e[0;91merror:\e[0m you can't run this without root access.\n" && exit

MAYA_BIN="/usr/local/bin"
MAYA_TREE="/usr/local/share/maya"
MAYA_REGISTRY="$MAYA_TREE/pkg/info"
MAYA_DOC="$MAYA_TREE/doc"
  
if [[ $1 == "--remove" ]]; then
    [[ ! -f "$MAYA_BIN"/maya && ! -d $MAYA_TREE ]] && printf "error\n" && exit
    rm -f $MAYA_BIN/maya
    rm -rf $MAYA_TREE
    exit
else
    set -x
    mkdir -p $MAYA_TREE $MAYA_REGISTRY $MAYA_DOC
    /usr/bin/install maya $MAYA_BIN
    /usr/bin/install {README,LICENSE} $MAYA_DOC
    cp -r {pkg,src} $MAYA_TREE
    set +x
    printf "\n\e[4m\e[1m%-51s\e[0m\n" "PATH:" && printf "\e[1m%-30s\e[0m%-0s\n" "Binary:" "$MAYA_BIN/maya" 
    printf "\e[1m%-30s\e[0m%-0s\n\n" "Documentation and PKG's:" "$MAYA_TREE"
fi