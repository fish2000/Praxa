#!/usr/bin/env bash

cd $VIRTUAL_ENV
if [[ -r ${VIRTUAL_ENV}/.password ]]
then
    export INSTANCE_PASSWORD=`cat ${VIRTUAL_ENV}/.password`
    export INSTANCE_PASSWORD_HASH=`sha256deep ${VIRTUAL_ENV}/.password | awk '{split($1,list,"\n")} END{print list[1]}'`
fi
