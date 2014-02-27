#!/usr/bin/env bash
# N.B. turn this into a makefile

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python # real variable (virtualenvwrapper)
export PIP_RESPECT_VIRTUALENV=true # real variable (pip)
export WORKON_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export WORKON_DEST="/usr/local/Praxa" # real variable (virtualenvwrapper)

export PRAXIME_BASE="${WORKON_HOME}/Praximes" # but a dream
export PIP_DOWNLOAD_CACHE="${PRAXIME_BASE}/PipCache" # real variable
export PRAXA_DOWNLOAD_CACHE="${PRAXIME_BASE}/PraxaCache" # but a dream
export PRAXON_INSTALL="${PRAXIME_BASE}/Install"
export PRAXON_LIBRARY="${PRAXIME_BASE}/Library"
export PRAXON_REQUIREMENTS="${PRAXIME_BASE}/Requirements"
export PRAXON_TEMPLATES="${PRAXIME_BASE}/Templates"

function load_praxon () {
    source "${PRAXIME_BASE}/${1:?praxtype expected}/${2:?praxon expected}.sh"
}

