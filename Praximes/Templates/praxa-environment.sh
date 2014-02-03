
# virtualenvwrapper. http://www.doughellmann.com/docs/virtualenvwrapper/
export VIRTUALENVWRAPPER_PYTHON=${PYTHON_BINARY}

export WORKON_HOME="${DIR}"
export PRAXIME_BASE="${WORKON_HOME}/Praximes"
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_DOWNLOAD_CACHE="${PRAXIME_BASE}/PipCache"
export PRAXA_DOWNLOAD_CACHE="${PRAXIME_BASE}/PraxaCache"

[[ ! -d $PIP_DOWNLOAD_CACHE ]] && mkdir -p $PIP_DOWNLOAD_CACHE
[[ ! -d $PRAXA_DOWNLOAD_CACHE ]] && mkdir -p $PRAXA_DOWNLOAD_CACHE
