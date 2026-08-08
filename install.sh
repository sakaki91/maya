#!/bin/bash

PATH_MAYA_BIN="/usr/local/bin"
PATH_MAYA_TREE="/usr/local/share/maya"
PATH_MAYA_REGISTRY="$MAYA_TREE/pkg/.info"
PATH_MAYA_DOC="$MAYA_TREE/doc"

if [[ $EUID == 0 ]]; then
    if [[ $1 == "--remove" ]]; then
        if [[ ! -f "$PATH_MAYA_BIN"/maya && ! -d $PATH_MAYA_TREE ]]; then
            printf "\033[0;91merror:\033[0m maya is not installed.\n"
        else
            rm -f $PATH_MAYA_BIN/maya
            rm -rf $PATH_MAYA_TREE
        fi
    else
        mkdir -p $PATH_MAYA_TREE $PATH_MAYA_REGISTRY $PATH_MAYA_DOC
        /usr/bin/install maya $PATH_MAYA_BIN
        /usr/bin/install {README,LICENSE} $PATH_MAYA_DOC
        cp -r {pkg,src} $PATH_MAYA_TREE
    fi
else
    printf "\033[0;91merror:\033[0m you can't run without root access.\n"
fi
