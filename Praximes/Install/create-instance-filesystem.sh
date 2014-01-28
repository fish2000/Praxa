#!/usr/bin/env bash

echo "+ Creating virtualenv subdirectories:"
cd $VIRTUAL_ENV
set -x
mkdir -p ./etc
mkdir -p ./var
mkdir -p ./var/logs
mkdir -p ./instance
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
mkdir -p ${LOCAL}
mkdir -p ${LOCAL_BIN}
mkdir -p ${LOCAL_LIB}
mkdir -p ${LOCAL_PYTHON}
mkdir -p ${LOCAL_PYTHON_SITE}
set +x
echo ""
