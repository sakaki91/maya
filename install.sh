#!/bin/bash

[[ $EUID != 0 ]] && printf "\e[0;91merror:\e[0m you can't run this without root access.\n" && exit

MAYA_BIN="/usr/local/bin"
MAYA_TREE="/usr/local/share/maya"
MAYA_REGISTRY="$MAYA_TREE/pkg/info"
MAYA_DOC="$MAYA_TREE/doc"

mkdir -p $MAYA_TREE $MAYA_REGISTRY $MAYA_DOC
/usr/bin/install maya $MAYA_BIN
/usr/bin/install {README,LICENSE} $MAYA_DOC
cp -r {pkg,src} $MAYA_TREE
printf "\e[0;92m::\e[0m execute: maya -h\n"
