#!/usr/bin/env bash

cd $VIRTUAL_ENV
INSTANCE_PASSWORD_FILE="${VIRTUAL_ENV}/.password"
echo "+ Reading password from ${INSTANCE_PASSWORD_FILE}:"
if [[ -r $INSTANCE_PASSWORD_FILE ]]; then
    export INSTANCE_PASSWORD=`cat ${INSTANCE_PASSWORD_FILE}`
    export INSTANCE_PASSWORD_HASH=`sha256deep ${INSTANCE_PASSWORD_FILE} | awk '{split($1,list,"\n")} END{print list[1]}'`
    echo "++ INSTANCE_PASSWORD=xxxxxxxxxxxxxxxxxx [not shown]"
    echo "++ INSTANCE_PASSWORD_HASH=${INSTANCE_PASSWORD_HASH}"
else
    echo "- WARNING: No readable password files found in virtualenv ${INSTANCE_NAME}"
    echo "- WARNING: Tried path: ${INSTANCE_PASSWORD_FILE}"
    echo "- WARNING: Errors may arise from the following unset env variables:"
    echo "- WARNING: undefined variable INSTANCE_PASSWORD"
    echo "- WARNING: undefined variable INSTANCE_PASSWORD_HASH"
fi
