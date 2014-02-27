#!/usr/bin/env bash

export PIP_RESPECT_VIRTUALENV=true # real variable (pip)
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python" # real variable (virtualenvwrapper)
export WORKON_HOME="$(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd)"

export PRAXIME_BASE="${WORKON_HOME}/Praximes" # but a dream
export PIP_DOWNLOAD_CACHE="${PRAXIME_BASE}/PipCache" # real variable
export PRAXA_DOWNLOAD_CACHE="${PRAXIME_BASE}/PraxaCache" # but a dream

export PIP_VIRTUALENV_BASE=$WORKON_HOME # real variable (pip)

[[ ! -d $PIP_DOWNLOAD_CACHE ]] && mkdir -p $PIP_DOWNLOAD_CACHE
[[ ! -d $PRAXA_DOWNLOAD_CACHE ]] && mkdir -p $PRAXA_DOWNLOAD_CACHE

# virtualenvwrapper. http://www.doughellmann.com/docs/virtualenvwrapper/
source /usr/local/bin/virtualenvwrapper.sh

