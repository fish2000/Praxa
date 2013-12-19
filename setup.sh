#!/usr/bin/env bash

download_to() {
    test ! -r ${2:?pathname expected} && test -x `which wget` && wget ${1:?URL expected} -O ${2:?pathname expected}
    test ! -r ${2:?pathname expected} && test -x `which curl` && curl -L ${1:?URL expected} -o ${2:?pathname expected}
    test ! -r ${2:?pathname expected} && test -x `which http` && http -d ${1:?URL expected} -o ${2:?pathname expected}
}

expand_into() {
    tar xvzf ${1:?tarball expected} --strip-components=1 --directory=${2:?pathname expected}
}

download_and_expand() {
    url="${1:?URL expected}"
    src_directory="${2:?pathname expected}"
    tmp_tarball="/tmp/$(basename ${url})"
    download_to $url $tmp_tarball
    expand_into $tmp_tarball $src_directory
    rm $tmp_tarball
}

export TMP=/tmp
export USR_LOCAL=/usr/local
export BIN=${USR_LOCAL}/bin
export LIB=${USR_LOCAL}/lib
export PYLIB=${LIB}/python2.7/site-packages

if [[ ! -d $USR_LOCAL ]]
then
    mkdir -p "${USR_LOCAL}"
    mkdir -p "${USR_LOCAL}/bin"
    mkdir -p "${USR_LOCAL}/lib"
    mkdir -p "${USR_LOCAL}/include"
    mkdir -p "${USR_LOCAL}/share"
    mkdir -p "${USR_LOCAL}/var"
    mkdir -p "${USR_LOCAL}/opt"
    mkdir -p "${USR_LOCAL}/etc"
fi

# install python
PYTHON_URL="http://python.org/ftp/python/2.7.6/Python-2.7.6.tgz"
PYTHON_TARBALL="/tmp/$(basename ${PYTHON_URL})"
PYTHON_SRC="${TMP}/python"
PYTHON_BINARY="/usr/local/bin/python"

SETUPTOOLS_URL="https://pypi.python.org/packages/source/s/setuptools/setuptools-1.3.2.tar.gz"
SETUPTOOLS_TARBALL="/tmp/$(basename ${SETUPTOOLS_URL})"
SETUPTOOLS_SRC="${TMP}/setuptools"

PIP_URL="https://pypi.python.org/packages/source/p/pip/pip-1.4.1.tar.gz"
PIP_TARBALL="/tmp/$(basename ${PIP_URL})"
PIP_SRC="${TMP}/pip"

cd $TMP && mkdir -p $PYTHON_SRC && mkdir -p $SETUPTOOLS_SRC && mkdir -p $PIP_SRC
download_to $PYTHON_URL $PYTHON_TARBALL
download_to $SETUPTOOLS_URL $SETUPTOOLS_TARBALL
download_to $PIP_URL $PIP_TARBALL

PYTHONHOME=""
PYTHONPATH=""

tar xvzf $PYTHON_TARBALL --strip-components=1 --directory=$PYTHON_SRC
cd $PYTHON_SRC && \
    ./configure \
        --prefix=$USR_LOCAL \
        --enable-ipv6 \
        --datadir=${USR_LOCAL}/share \
        --datarootdir=${USR_LOCAL}/share && \
            make && make install

tar xvzf $SETUPTOOLS_TARBALL --strip-components=1 --directory=$SETUPTOOLS_SRC
cd $SETUPTOOLS_SRC && test -x $PYTHON_BINARY && \
    eval "${PYTHON_BINARY} setup.py --no-usr-cfg \
        install --force --verbose \
        --install-scripts=${BIN} \
        --install-lib=${PYLIB}"

tar xvzf $PIP_TARBALL --strip-components=1 --directory=$PIP_SRC
cd $PIP_SRC && test -x $PYTHON_BINARY && \
    eval "${PYTHON_BINARY} setup.py --no-usr-cfg \
        install --force --verbose \
        --install-scripts=${BIN} \
        --install-lib=${PYLIB}"


cd $TMP
rm $PYTHON_TARBALL $SETUPTOOLS_TARBALL $PIP_TARBALL
rm -rf $PYTHON_SRC $SETUPTOOLS_SRC $PIP_SRC

# install git
# GIT_URL="https://github.com/git/git/archive/master.tar.gz"
# GIT_TARBALL="/tmp/git-source.tar.gz"
# GIT_SRC="${TMP}/git"
# cd $TMP && mkdir -p $GIT_SRC
# download_to $GIT_URL $GIT_TARBALL
# tar xvzf $GIT_TARBALL --strip-components=1 --directory=$GIT_SRC
# V=1
# NO_FINK=1
# NO_DARWIN_PORTS=1
# NO_R_TO_GCC_LINKER=1
# PYTHON_PATH=/usr/local/bin/python
# PERL_PATH=`which perl`
# NO_PERL_MAKEMAKER=1
# cd $GIT_SRC && \
#     make configure && \
#     ./configure --prefix=$USR_LOCAL --sysconfdir=${USR_LOCAL}/etc && \
#     make -j 4 && \
#     make install
# cd $TMP
# rm $GIT_TARBALL
# rm -rf $GIT_SRC


# set up Praxa
export WORKON_HOME="/usr/local/Praxa"
export PRAXIME_BASE="${WORKON_HOME}/Praximes"
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_DOWNLOAD_CACHE=${PRAXIME_BASE}/PipCache
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python

if [[ ! -d $WORKON_HOME ]]
then
    mkdir -p $WORKON_HOME
fi

git clone https://github.com/fish2000/Praxa.git /tmp/YoDogg

if [[ ! -d $PIP_DOWNLOAD_CACHE ]]
then
    mkdir -p $PIP_DOWNLOAD_CACHE
fi

source /usr/local/bin/virtualenvwrapper.sh
