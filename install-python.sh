#!/usr/bin/env bash

export TMP="/tmp"
#export USR_LOCAL=/usr/local
export USR_LOCAL="${TMP}/YoDogg"

export PYTHONPATH=""
export PYTHONHOME=$USR_LOCAL

export BIN=${USR_LOCAL}/bin
export LIB=${USR_LOCAL}/lib
export INCLUDE=${USR_LOCAL}/include
export SHARE=${USR_LOCAL}/share
export VAR=${USR_LOCAL}/var
#export OPT=${USR_LOCAL}/opt
export ETC=${USR_LOCAL}/etc
export PYLIB=${LIB}/python2.7/site-packages

export PATH="${BIN}:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/bin"

download_to() {
    in_url="${1:?URL expected}"
    out_file="${2:?pathname expected}"
    [[ -r $out_file ]] && echo "- Already exists: ${out_file}" && return
    echo "+ Fetching URL: ${in_url}"
    echo "+ Downloading to file: ${out_file}"
    test ! -r $out_file && test -x `which wget` && wget $in_url -O $out_file
    test ! -r $out_file && test -x `which curl` && curl -L $in_url -o $out_file
    test ! -r $out_file && test -x `which http` && http -d $in_url -o $out_file
    test ! -r $out_file && "- Couldn't download. Tried: wget, curl, httpie"
}

expand_tarball_to() {
    in_tarball="${1:?tarball expected}"
    out_directory="${2:?pathname expected}"
    [[ ! -r $in_tarball ]] && echo "- Can't read tarball: ${in_tarball}" && return
    [[ -d $out_directory ]] && rm -rf $out_directory
    mkdir -p $out_directory
    echo "+ Expanding tarball: ${in_tarball}"
    tar xzf $in_tarball --strip-components=1 --directory=$out_directory
}

download_and_expand() {
    url="${1:?URL expected}"
    url_basename="$(basename ${url})"
    src_directory="${2:?pathname expected}"
    tmp_tarball="${TMP}/${url_basename}"
    download_to $url $tmp_tarball
    expand_tarball_to $tmp_tarball $src_directory
    rm $tmp_tarball
}

cd $TMP

if [[ ! -d $USR_LOCAL ]]
then
    mkdir -p "${USR_LOCAL}"
    mkdir -p "${BIN}"
    mkdir -p "${LIB}"
    mkdir -p "${INCLUDE}"
    mkdir -p "${SHARE}"
    mkdir -p "${VAR}"
    #mkdir -p "${OPT}"
    mkdir -p "${USR_LOCAL}/opt"
    mkdir -p "${ETC}"
    mkdir -p "${PYLIB}"
fi

# install python
export PYTHON_URL="http://python.org/ftp/python/2.7.6/Python-2.7.6.tgz"
export PYTHON_SRC="${TMP}/python-2.7.6-src"
export PYTHON_BINARY="${BIN}/python"
export SETUPTOOLS_URL="https://pypi.python.org/packages/source/s/setuptools/setuptools-1.3.2.tar.gz"
export SETUPTOOLS_SRC="${TMP}/setuptools-1.3.2-src"
export PIP_URL="https://pypi.python.org/packages/source/p/pip/pip-1.4.1.tar.gz"
export PIP_SRC="${TMP}/pip-1.4.1-src"

rm "${TMP}/*.tgz"
rm "${TMP}/*.tar.gz"
rm -rf $PYTHON_SRC
rm -rf $SETUPTOOLS_SRC
rm -rf $PIP_SRC

cd $TMP && mkdir -p $PYTHON_SRC && mkdir -p $SETUPTOOLS_SRC && mkdir -p $PIP_SRC

export CC=clang
export CXX=clang++

#-I/usr/local/include \
export CFLAGS="-fno-strict-aliasing -fno-common \
    -I/usr/local/include \
    -I/usr/local/opt/sqlite/include \
    -DNDEBUG \
    -g -fwrapv -O3 \
    -Wall -Wstrict-prototypes"

export LDFLAGS="\
    -L/usr/local/lib \
    -L/usr/local/opt/sqlite/lib \
    -ldl -framework CoreFoundation"

export MACOSX_DEPLOYMENT_TARGET="10.9"

cd $TMP
download_and_expand $PYTHON_URL $PYTHON_SRC
cd $PYTHON_SRC && \
    ./configure \
        --prefix=$USR_LOCAL \
        --without-gcc \
        --enable-ipv6 \
        --enable-shared && \
    make && make install

[[ ! -d $PYLIB ]] && mkdir -p $PYLIB

cd $TMP
download_and_expand $SETUPTOOLS_URL $SETUPTOOLS_SRC
cd $SETUPTOOLS_SRC && test -x $PYTHON_BINARY && \
    PYTHONHOME=${USR_LOCAL} \
        python ./setup.py install \
            --force --verbose \
            --prefix=${USR_LOCAL} \
            --install-scripts=${BIN}

cd $TMP
download_and_expand $PIP_URL $PIP_SRC
cd $PIP_SRC && test -x $PYTHON_BINARY && \
    PYTHONHOME=${USR_LOCAL} \
        python ./setup.py install \
            --force --verbose \
            --prefix=${USR_LOCAL} \
            --install-scripts=${BIN}

cd $TMP
rm -rf $PYTHON_SRC $SETUPTOOLS_SRC $PIP_SRC

