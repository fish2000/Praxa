#!/usr/bin/env bash
# This is sourced in your .bash_profile or .bashrc --
# in place of e.g. `source /usr/local/bin/virtualenvwrapper.sh`

: ${VIRTUALENVWRAPPER_PYTHON:="/usr/local/bin/python"} # real variable (virtualenvwrapper)
: ${VIRTUALENVWRAPPER_VIRTUALENV:="/usr/local/bin/virtualenv"} # real variable (virtualenvwrapper)
: ${VIRTUALENVWRAPPER_VIRTUALENV_ARGS:="--no-site-packages --verbose" ${VENV_ARGS}} # real variable (virtualenvwrapper)
: ${VIRTUALENVWRAPPER_SCRIPT:="/usr/local/bin/virtualenvwrapper.sh"} # real variable (virtualenvwrapper)
: ${WORKON_HOME:=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)} # real variable (virtualenvwrapper)

#export PROJECT_HOME="${WORKON_HOME}/Projects" # real variable (virtualenvwrapper)
export PRAXIME_BASE="${WORKON_HOME}/Praximes" # but a dream
export PRAXA_DOWNLOAD_CACHE="${PRAXIME_BASE}/PraxaCache" # but a dream
export PIP_VIRTUALENV_BASE=$WORKON_HOME # real variable (pip)
export PIP_RESPECT_VIRTUALENV=true # real variable (pip)

export VIRTUALENVWRAPPER_HOOK_DIR="${PRAXIME_BASE}/EnvHooks" # real variable (virtualenvwrapper)

[[ ! -d $PRAXA_DOWNLOAD_CACHE ]] && mkdir -p $PRAXA_DOWNLOAD_CACHE

export WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON
export VIRTUALENVWRAPPER_VIRTUALENV
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS
export VIRTUALENVWRAPPER_SCRIPT

# snag some good funcs for everyday use and great value
function is_dir () { 
    (cd ${1:?pathname expected}) || return
}

function load_praxon () {
    source "${PRAXIME_BASE}/Library/${1:?praxon expected}.sh"
}

function install_praxon () {
    source "${PRAXIME_BASE}/Install/${1:?praxon expected}.sh"
}

# function vremove () {
#     is_dir "${VIRTUAL_ENV}/${1:?pathname expected}" && rm -rf "${VIRTUAL_ENV}/${1}"
# }

# prepare bash funcs for download/install praxons 
load_praxon "download"
load_praxon "urlcache"

# throw it over to virtualenvwrapper
source $VIRTUALENVWRAPPER_SCRIPT

