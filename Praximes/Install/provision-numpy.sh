#!/usr/bin/env bash

if PYPY; then
    # We're under pypy --
    # Do a checkout of their latest source,
    # and build from there
    cd $INSTANCE_VARIANT
    echo "+ Installing numpypy -- numpy for pypy:"
    git clone https://bitbucket.org/pypy/numpy.git
    
    cd numpy
    ${VIRTUAL_ENV}/bin/pypy setup.py install

    cd $INSTANCE_VARIANT
    rm -rf numpy

    cd $VIRTUAL_ENV
else
    # We're under cpython --
    # do a typical numpy pip-install
    echo "+ Installing numpy:"
    ${VIRTUAL_ENV}/bin/pip install -U numpy
fi
