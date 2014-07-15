#!/usr/bin/env bash


echo "+ Installing nodeenv"
cd ${VIRTUAL_ENV}
bin/pip install -U nodeenv

echo ""
if [[ -x $(which nodeenv) ]]; then
    echo "+ Installing node.js"
    bin/nodeenv -p -v -c -n 0.11.13 $NODE_MODULES_DIRECTORY
else
    echo "- WARNING: couldn't find the nodeenv script"
fi

if [[ -x ${INSTANCE_BIN}/node ]]; then
    echo "+ Installing Grunt via npm"
    bin/npm -g install grunt
    bin/npm -g install grunt-cli
    bin/npm -g install grunt-init
    cd ${VIRTUAL_ENV}
else
    echo "- WARNING: no node executeable found in ${INSTANCE_BIN}"
fi


