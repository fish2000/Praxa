#!/usr/local/bin/bash -l

shopt -s expand_aliases
set -o posix
VENV=$1

if [ -z $VENV ]
then
    echo "usage: vx [virtualenv] CMDS [...]"
else
    shift 1
    echo "vx: executing $@ in ${VENV} ..."
    echo ""

    if [[ -r ${WORKON_HOME}/${VENV}/bin/activate ]]
    then
        source ${WORKON_HOME}/${VENV}/bin/activate
        workon $VENV
        eval $@
        echo ""
        deactivate
    else
        echo "vx: no virtualenv named ${VENV}"
    fi
fi
