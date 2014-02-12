#!/usr/bin/env bash

export TMP="/tmp"
export USR_LOCAL=/usr/local
#export USR_LOCAL="${TMP}/YoDogg"

export PYTHONPATH=""
export PYTHONHOME=$USR_LOCAL

export BIN=${USR_LOCAL}/bin
export LIB=${USR_LOCAL}/lib
export INCLUDE=${USR_LOCAL}/include
export SHARE=${USR_LOCAL}/share
export VAR=${USR_LOCAL}/var
#export OPT=${USR_LOCAL}/opt
export ETC=${USR_LOCAL}/etc
export PYLIB=${LIB}/python2.7/site-packages

export PATH="${BIN}:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/bin"

user_bash_script () {
    if [[ "$1" ]]
    then
        script=$1
    else
        script=~/.bash_profile
    fi
    test -r $script \
        && echo $script || echo ~/.bashrc
}

if [[ ! -d $USR_LOCAL ]]
then
    echo "+ Creating ${USR_LOCAL} and subdirectories..."
    mkdir -p "${USR_LOCAL}"
    mkdir -p "${BIN}"
    mkdir -p "${LIB}"
    mkdir -p "${INCLUDE}"
    mkdir -p "${SHARE}"
    mkdir -p "${VAR}"
    #mkdir -p "${OPT}"
    mkdir -p "${USR_LOCAL}/opt"
    mkdir -p "${ETC}"
    mkdir -p "${PYLIB}"
fi
