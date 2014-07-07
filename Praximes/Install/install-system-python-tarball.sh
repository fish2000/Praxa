#!/usr/bin/env bash
#       
#       Python Install Praxon
#       Praxa/Praximes/Install/python-tarball.sh
#       Builds and installs the latest Python 2 release,
#           from the officiall source distribution tarball.
#       
#       Written by Alexander Böhn -- @fish2000
#       © 2013 Objects In Space And Time, LLC. All Rights Reserved.
#       See Praxa/LICENSE.md for terms: http://git.io/h_eMZw
#       
#       Required definitions:
#           - TMP (temporary directory)
#           - USR_LOCAL ("/usr/local" or equiv)
#           - PYLIB (putative python "site-packages" dir)
#
#       Exported definitions:
#           + PYTHON_BINARY (it is the motherfucking python binary)
#

cd $TMP

PYTHON_VERSION="2.7.8"
#SETUPTOOLS_VERSION="1.3.2"
SETUPTOOLS_VERSION="5.4.1"
PIP_VERSION="1.5.6"
MACOSX_DEPLOYMENT_TARGET="10.9"

echo "+ Preparing to build python from source tarball ..."
PYTHON_URL="http://python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz"
PYTHON_SRC="${TMP}/python-${PYTHON_VERSION}-src"
SETUPTOOLS_URL="https://pypi.python.org/packages/source/s/setuptools/setuptools-${SETUPTOOLS_VERSION}.tar.gz"
SETUPTOOLS_SRC="${TMP}/setuptools-${SETUPTOOLS_VERSION}-src"
PIP_URL="https://pypi.python.org/packages/source/p/pip/pip-${PIP_VERSION}.tar.gz"
PIP_SRC="${TMP}/pip-${PIP_VERSION}-src"
export PYTHON_BINARY="${BIN}/python"

rm "${TMP}/*.tgz"
rm "${TMP}/*.tar.gz"
rm -rf $PYTHON_SRC
rm -rf $SETUPTOOLS_SRC
rm -rf $PIP_SRC

cd $TMP && mkdir -p $PYTHON_SRC && mkdir -p $SETUPTOOLS_SRC && mkdir -p $PIP_SRC

CC=clang
CXX=clang++
CFLAGS="-fno-strict-aliasing -fno-common \
    -I/usr/local/include \
    -I/usr/local/opt/sqlite/include \
    -DNDEBUG \
    -g -fwrapv -O3 \
    -Wall -Wstrict-prototypes"

LDFLAGS="\
    -L/usr/local/lib \
    -L/usr/local/opt/sqlite/lib \
    -ldl -framework CoreFoundation"

echo "+ Downloading and installing python ${PYTHON_VERSION} ..."
cd $TMP
download_and_expand $PYTHON_URL $PYTHON_SRC
cd $PYTHON_SRC && \
    ./configure \
        --prefix=$USR_LOCAL \
        --without-gcc \
        --enable-ipv6 \
        --enable-shared \
        --enable-unicode=ucs4 && \
    make && make install

[[ ! -d $PYLIB ]] && mkdir -p $PYLIB

echo "+ Downloading and installing setuptools ${SETUPTOOLS_VERSION} ..."
cd $TMP
download_and_expand $SETUPTOOLS_URL $SETUPTOOLS_SRC
cd $SETUPTOOLS_SRC && test -x $PYTHON_BINARY && \
    PYTHONHOME=${USR_LOCAL} \
        python ./setup.py install --force \
            --prefix=${USR_LOCAL} \
            --install-scripts=${BIN}

echo "+ Downloading and installing pip ${PIP_VERSION} ..."
cd $TMP
download_and_expand $PIP_URL $PIP_SRC
cd $PIP_SRC && test -x $PYTHON_BINARY && \
    PYTHONHOME=${USR_LOCAL} \
        python ./setup.py install --force \
            --prefix=${USR_LOCAL} \
            --install-scripts=${BIN}

echo "+ Cleaning up after python install from tarball ..."
cd $TMP
rm -rf $PYTHON_SRC
rm -rf $SETUPTOOLS_SRC
rm -rf $PIP_SRC
