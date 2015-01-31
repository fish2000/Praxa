#!/usr/bin/env bash
# N.B. turn this into a makefile

source "/Users/fish/Praxa/env.sh"
export WORKON_SRC="/Users/fish/Praxa"
export WORKON_DEST="/usr/local/Praxa" # real variable (virtualenvwrapper)
 
# export PRAXON_INSTALL="${PRAXIME_BASE}/Install"
# export PRAXON_LIBRARY="${PRAXIME_BASE}/Library"
# export PRAXON_REQUIREMENTS="${PRAXIME_BASE}/Requirements"
# export PRAXON_TEMPLATES="${PRAXIME_BASE}/Templates"
 
# function load_praxon () {
#     source "${PRAXIME_BASE}/${1:?praxtype expected}/${2:?praxon expected}.sh"
# } 

if [[ -d $WORKON_DEST ]]; then
    cd "${WORKON_DEST}/.." && rm -rf $WORKON_DEST
fi

mkdir -p $WORKON_DEST

if [[ -x `which ditto` ]]; then
    ditto -V $WORKON_HOME $WORKON_DEST | grep -v "bytes for"
else
    cp -a -v $WORKON_HOME/ $WORKON_DEST
fi

find $WORKON_DEST -type f -print -exec sed -i '~' -E -e 's#${WORKON_SRC}#${WORKON_DEST}#' {} +
#find $WORKON_DEST -name "\*~" -print -delete