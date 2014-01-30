#!/usr/bin/env bash

cd $VIRTUAL_ENV
if [[ -r "${TEMPLATES}/.password" ]]
then
    export INSTANCE_PASSWORD="$(cat ${TEMPLATES}/.password)"
else
    export INSTANCE_PASSWORD="XXX"
fi
echo "+ Writing the instance default password \"${INSTANCE_PASSWORD}\" to ${VIRTUAL_ENV}/.password ..."
echo $INSTANCE_PASSWORD > ${VIRTUAL_ENV}/.password
export INSTANCE_PASSWORD_HASH=`sha256deep ${VIRTUAL_ENV}/.password | awk '{split($1,list,"\n")} END{print list[1]}'`