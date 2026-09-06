#!/bin/bash

if [[ $EUID == 0 ]]; then
    if [[ $1 == "--remove" ]]; then
        if [[ ! -f /usr/local/bin/maya && ! -d /usr/local/share/maya ]]; then
            printf "\033[0;91merror:\033[0m maya is not installed.\n"
        else
            /usr/bin/rm -f /usr/local/bin/maya
            /usr/bin/rm -rf /usr/local/share/maya
        fi
    else
        /usr/bin/mkdir -p /usr/local/bin
        /usr/bin/mkdir -p /usr/local/share/maya/doc
        /usr/bin/cp -r {pkg,src} /usr/local/share/maya/
        /usr/bin/mkdir -p /usr/local/share/maya/pkg/.info
        /usr/bin/install maya /usr/local/bin
        /usr/bin/install {README,LICENSE} /usr/local/share/maya/doc
    fi
else
    printf "\033[0;91merror:\033[0m you can't run without root access.\n"
fi