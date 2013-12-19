
# virtualenvwrapper. http://www.doughellmann.com/docs/virtualenvwrapper/
export WORKON_HOME="${DIR}"
export PRAXIME_BASE="${WORKON_HOME}/Praximes"
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_DOWNLOAD_CACHE="${PRAXIME_BASE}/PipCache"
export VIRTUALENVWRAPPER_PYTHON=${PYTHON_BINARY}

if [[ ! -d $PIP_DOWNLOAD_CACHE ]]
then
    mkdir -p $PIP_DOWNLOAD_CACHE
fi
