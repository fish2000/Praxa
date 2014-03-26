#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Creating virtualenv subdirectories:"

set -x
mkdir -p ./etc
mkdir -p ./var
mkdir -p ./var/logs
mkdir -p ./instance
mkdir -p ${IPYTHONDIR}
mkdir -p ${INSTANCE_VARIANT_DATA}
mkdir -p ${INSTANCE_VARIANT_DATA}/redis
mkdir -p ${INSTANCE_VARIANT_DATA}/postgresql
mkdir -p ${INSTANCE_VARIANT_DATA}/mysql
mkdir -p ${INSTANCE_VARIANT}/web
mkdir -p ${INSTANCE_VARIANT}/web/static
mkdir -p ${INSTANCE_VARIANT}/web/face
mkdir -p ${INSTANCE_LOGS}
mkdir -p ${INSTANCE_CACHE}
mkdir -p ${INSTANCE_RUN}
mkdir -p ${INSTANCE_TMP}
mkdir -p ${INSTANCE_MODULE}

# mkdir -p ${INSTANCE_STATIC}
# mkdir -p ${INSTANCE_STATIC}/css
# mkdir -p ${INSTANCE_STATIC}/img
# mkdir -p ${INSTANCE_STATIC}/js
# All this needs to get re-thunk: this 'static' subtree is nice and all, and it's fine there, in the django project directory... but it belongs in an APP. And what I am now learning is this: it is dumb to include any 'default' 'convenience' app boilerplate stuff in the templated venv stuff, because it will always be wrong, and I will just end up doubly wasting time when I inevitabley have to spend just as much time disentangling and deleting the 'default app' as I frittered away being clever while writing it. F that.

mkdir -p ${LOCAL}
mkdir -p ${LOCAL_BIN}
mkdir -p ${LOCAL_LIB}
mkdir -p ${LOCAL_INCLUDE}
mkdir -p ${LOCAL_PYTHON}
mkdir -p ${LOCAL_PYTHON_SITE}
set +x
