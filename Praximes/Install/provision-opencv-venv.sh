#!/usr/bin/env bash

cd $VIRTUAL_ENV
# install numpy or numpypy conditionally
install_praxon "provision-numpy"

cd $INSTANCE_VARIANT
echo ""
echo "+ Installing OpenCV"
OPENCV_VERSION="3.0.0-beta"
OPENCV_DIRNAME="opencv-${OPENCV_VERSION}"
OPENCV_ZIPNAME="${OPENCV_VERSION}.zip"
# OPENCV_URL="http://iweb.dl.sourceforge.net/project/opencvlibrary/opencv-unix/${OPENCV_VERSION}/${OPENCV_ZIPNAME}"
OPENCV_URL="https://github.com/Itseez/opencv/archive/${OPENCV_ZIPNAME}"

fetch_and_expand $OPENCV_URL $OPENCV_DIRNAME

cd $OPENCV_DIRNAME
[[ -d macbuild ]] && rm -rf macbuild
mkdir macbuild
cd macbuild

CC="$(brew --prefix llvm)/bin/clang" \
CXX="$(brew --prefix llvm)/bin/clang++" \
CXXFLAGS="-std=c++11 --stdlib=libc++" \
LDFLAGS="-lc++" \
cmake .. \
    -DCMAKE_INSTALL_PREFIX=$VIRTUAL_ENV \
    -DCMAKE_BUILD_TYPE=None \
    -DCMAKE_VERBOSE_MAKEFILE=OFF \
    -Wno-dev \
    -DCMAKE_OSX_DEPLOYMENT_TARGET= \
    -DWITH_CUDA=OFF \
    -DBUILD_ZLIB=OFF \
    -DBUILD_TIFF=OFF \
    -DBUILD_PNG=OFF \
    -DBUILD_JPEG=OFF \
    -DBUILD_JASPER=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DWITH_TBB=ON \
    -DWITH_GCD=ON \
    -DWITH_CONCURRENCY=ON \
    -DWITH_OPENCL=ON \
    -DWITH_FFMPEG=OFF \
    -DWITH_PYTHON=ON \
    -DBUILD_PYTHON_SUPPORT=ON \
    -DPYTHON_LIBRARY="$(python-config --prefix)/lib/libpython2.7.dylib" \
    -DPYTHON_EXECUTABLE=${VIRTUAL_ENV}/bin/python2.7 \
    -DPYTHON_INCLUDE=${VIRTUAL_ENV}/include/python2.7/ \
    -DPYTHON_PACKAGES_PATH=${INSTANCE_PYTHON_SITE} \
    -DPYTHON_NUMPY_INCLUDE_DIR=${INSTANCE_PYTHON_SITE}/numpy/core/include/ \
    -DENABLE_SSSE3=ON \
    -DENABLE_SSE41=ON \
    -DENABLE_SSE42=ON \
    -DENABLE_AVX=ON \
        && \
        make -j4 \
        && \
        make install

cd $INSTANCE_VARIANT
echo "+ Cleaning up OpenCV build artifacts"
rm -rf $OPENCV_DIRNAME
