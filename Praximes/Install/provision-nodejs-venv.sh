#!/usr/bin/env bash


echo "+ Installing nodeenv"
cd ${VIRTUAL_ENV}
bin/pip install -U nodeenv

echo ""
if [[ -x $(which nodeenv) ]]; then
    echo "+ Installing node.js"
    bin/nodeenv -p -v -c $NODE_MODULES_DIRECTORY
else
    echo "- WARNING: couldn't find the nodeenv script"
fi

if [[ -x ${INSTANCE_BIN}/node ]]; then
    export NODE_VERSION=`${INSTANCE_BIN}/node --version | sed -e s/^v//`
    #FULLNAME=`finger -g -p -l -h ${USER} 2> /dev/null | grep -i name | awk '{split($0,list,":")} END{print list[3]}' | sed -e s/^\ //`
    #USER_FULLNAME=`[[ $fullname == "" ]] && echo $USER || echo $FULLNAME`
    export USER_NAME=`git config --get user.name || echo "$USER"`
    export USER_EMAIL=`git config --get user.email`
    GITHUB=`git config --get github.name`
    export USER_URL=`[[ $GITHUB == "" ]] && echo "" || echo "http://github.com/${GITHUB}"`
    export REPO_GUESS=`[[ $GITHUB == "" ]] && echo "" || echo "git@github.com:${GITHUB}/${INSTANCE_NAME}.git"`
    export HOMEPAGE_GUESS=`[[ $GITHUB == "" ]] && echo "" || echo "http://github.com/${GITHUB}/${INSTANCE_SAFE_NAME}"`
    
    echo "+ Installing Grunt via npm"
    bin/npm -g install grunt
    bin/npm -g install grunt-cli
    bin/npm -g install grunt-init
    
    echo "+ Creating local export of the Grunt node template repo"
    #GRUNT_TEMPLATE_REPO="https://github.com/gruntjs/grunt-init-node.git"
    #mkdir -p $NODE_GRUNT_TEMPLATE
    svn export https://github.com/gruntjs/grunt-init-node/trunk ${NODE_GRUNT_TEMPLATE}
    
    echo "+ Writing Grunt defaults.json file"
    bin/viron ${TEMPLATES}/grunt-defaults.json > ${NODE_GRUNT_TEMPLATE}/defaults.json
    
    echo "+ Creating directory ${NODECODE}"
    mkdir -p $NODECODE
    
    #echo "+ Writing instance package.json file"
    #bin/viron ${TEMPLATES}/npm-package.json > ${NODECODE}/package.json
    #${INSTANCE_BIN}/npm update
    
    cd $NODECODE
    echo "Initializing instance javascript scaffolding via Grunt"
    grunt-init ${NODE_GRUNT_TEMPLATE}
    
    cd ${VIRTUAL_ENV}
    
else
    echo "- WARNING: no node executeable found in ${INSTANCE_BIN}"
fi


