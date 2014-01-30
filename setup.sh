#!/usr/bin/env bash
# N.B. turn this into a makefile

# where am I? (see http://stackoverflow.com/a/246128/298171)
export WORKON_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export PRAXIME_BASE="${WORKON_HOME}/Praximes"
export PRAXON_TEMPLATES="${PRAXIME_BASE}/Templates"
export PRAXA_SETUP="${BASH_SOURCE[0]}"
export OLD_PATH=$PATH
export TMP="/tmp"

function load_praxon () {
    source "${PRAXIME_BASE}/${1:?praxtype expected}/${2:?praxon expected}.sh"
}

cd $WORKON_HOME
if [[ ! -d Praximes ]];
then
    echo ""
    echo "*** ERROR: ${PRAXA_SETUP} needs to run from the repository root."
    echo "*** For details see: https://github.com/fish2000/Praxa"
    echo "*** Halting setup..."
    exit
fi

# load foundation praxonics
load_praxon "Library" "00-basics"
load_praxon "Library" "01-download"

# install python
[[ `uname -s` == "Darwin" ]] \
    && load_praxon "Install" "python-homebrew" \
    || load_praxon "Install" "python-tarball"

# install virtualenv and virtualenvwrapper
load_praxon "Install" "python-postinstall"

