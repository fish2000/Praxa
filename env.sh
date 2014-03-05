#!/usr/bin/env bash
# This is sourced in your .bash_profile or .bashrc --
# in place of e.g. `source /usr/local/bin/virtualenvwrapper.sh`

export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python" # real variable (virtualenvwrapper)
export VIRTUALENVWRAPPER_VIRTUALENV="/usr/local/bin/virtualenv" # real variable (virtualenvwrapper)
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages' # real variable (virtualenvwrapper)
export VIRTUALENVWRAPPER_SCRIPT="/usr/local/bin/virtualenvwrapper.sh" # real variable (virtualenvwrapper)

export WORKON_HOME=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd) # real variable (virtualenvwrapper)
export PROJECT_HOME="${WORKON_HOME}/Projects" # real variable (virtualenvwrapper)
export PRAXIME_BASE="${WORKON_HOME}/Praximes" # but a dream
export PRAXA_DOWNLOAD_CACHE="${PRAXIME_BASE}/PraxaCache" # but a dream
export PIP_DOWNLOAD_CACHE="${PRAXIME_BASE}/PipCache" # real variable (pip)
export PIP_VIRTUALENV_BASE=$WORKON_HOME # real variable (pip)
export PIP_RESPECT_VIRTUALENV=true # real variable (pip)

export VIRTUALENVWRAPPER_HOOK_DIR="${PRAXIME_BASE}/EnvHooks" # real variable (virtualenvwrapper)

[[ ! -d $PIP_DOWNLOAD_CACHE ]] && mkdir -p $PIP_DOWNLOAD_CACHE
[[ ! -d $PRAXA_DOWNLOAD_CACHE ]] && mkdir -p $PRAXA_DOWNLOAD_CACHE

# throw it over to virtualenvwrapper
source $VIRTUALENVWRAPPER_SCRIPT

