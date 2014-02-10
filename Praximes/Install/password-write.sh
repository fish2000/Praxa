#!/usr/bin/env bash

cd $VIRTUAL_ENV
PRAXA_PASSWORD_FILE="${TEMPLATES}/.password"
INSTANCE_PASSWORD_FILE="${VIRTUAL_ENV}/.password"
if [[ -r $PRAXA_PASSWORD_FILE ]]; then
    echo "+ Reading default Praxa password from ${PRAXA_PASSWORD_FILE}:"
    echo "++ INSTANCE_PASSWORD=xxxxxxxxxxxxxxxxxx [not shown]"
    export INSTANCE_PASSWORD="$(cat ${PRAXA_PASSWORD_FILE})"
else
    echo "- WARNING: Couldn't find a readable password file in ${TEMPLATES}"
    echo "- WARNING: Tried path: ${PRAXA_PASSWORD_FILE}"
    echo "- WARNING: INSTANCE_PASSWORD initialized to default: 'XXX'"
    export INSTANCE_PASSWORD="XXX"
fi
echo "+ Writing .password file for virtualenv ${INSTANCE_NAME}"
echo $INSTANCE_PASSWORD > $INSTANCE_PASSWORD_FILE
echo "+ Password stored in ${INSTANCE_PASSWORD_FILE}"
export INSTANCE_PASSWORD_HASH=`sha256deep ${INSTANCE_PASSWORD_FILE} | awk '{split($1,list,"\n")} END{print list[1]}'`
echo "++ INSTANCE_PASSWORD_HASH=${INSTANCE_PASSWORD_HASH}"
