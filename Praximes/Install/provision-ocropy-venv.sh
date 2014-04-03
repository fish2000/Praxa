#!/usr/bin/env bash

cd $INSTANCE_TMP
fetch_and_expand http://cairographics.org/releases/py2cairo-1.10.0.tar.bz2 py2cairo
cd py2cairo
#./waf configure --prefix=$VIRTUAL_ENV
#./waf build
#./waf install
autoreconf -ivf
./configure --prefix=$VIRTUAL_ENV --disable-dependency-tracking
make
make install
cd $INSTANCE_TMP
rm -rf py2cairo

cd $INSTANCE_TMP
fetch_and_expand http://ftp.gnome.org/pub/GNOME/sources/pygobject/2.28/pygobject-2.28.6.tar.bz2 pygobject
cd pygobject
./configure --prefix=$VIRTUAL_ENV --disable-introspection
make
make install
cd $INSTANCE_TMP
rm -rf pygobject


cd $INSTANCE_TMP
fetch_and_expand http://pypi.python.org/packages/source/P/PyGTK/pygtk-2.24.0.tar.bz2 pygtk
cd pygtk
export PKG_CONFIG_PATH=${LOCAL_LIB}/pkgconfig:${INSTANCE_LIB}/pkgconfig:$PKG_CONFIG_PATH
./configure --prefix=$VIRTUAL_ENV
make
make install
cd $INSTANCE_TMP
rm -rf pygtk

cd $VIRTUAL_ENV
vremove build
#bin/pip install -U matplotlib

#set +x
cd $INSTANCE_TMP
rm -rf ocropus
#${INSTANCE_BIN}/hg clone -r ocropus-0.7 https://code.google.com/p/ocropus
${INSTANCE_BIN}/hg clone https://code.google.com/p/ocropus
cd ocropus/ocropy
#sudo apt-get install $(cat PACKAGES)

find . -type f \
    \! \( -path \*.hg\*  \) \
    -iname \*.pyc -print -delete

find . -type f \
    \! \( -iname \*.png  \) \
    \! \( -path \*.hg\*  \) \
    -print -exec \
        sed -i '' -E -e \
            's|^#!/usr/bin/python|#!/usr/bin/env python|' {} +
#find . -type f -name \*~ -print -delete 

sed -i '' -E -e 's/gcc/gcc-4.7/g' ocrolib/native.py

${INSTANCE_BIN}/python setup.py download_models
${INSTANCE_BIN}/python setup.py install
./run-test
#set -x