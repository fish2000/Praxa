#!/usr/bin/env bash


echo "+ Installing nodeenv ..."
cd ${VIRTUAL_ENV}
bin/pip install -U nodeenv

NODE_MODULES_DIRECTORY="${INSTANCE_LIB}/node_modules"

echo ""
if [[ -x $(which nodeenv) ]]; then
    echo "+ Installing node.js ..."
    bin/nodeenv -p -v -c $NODE_MODULES_DIRECTORY
else
    echo "- WARNING: couldn't find the nodeenv script"
fi
