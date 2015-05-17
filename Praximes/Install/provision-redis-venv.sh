#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Installing Redis server"

cd $INSTANCE_TMP

REDIS_VERSION="3.0.1"
REDIS_DIRNAME="redis-${REDIS_VERSION}"
REDIS_TARBALL="${REDIS_DIRNAME}.tar.gz"
REDIS_URL="http://download.redis.io/releases/${REDIS_TARBALL}"

fetch_and_expand $REDIS_URL $REDIS_DIRNAME

cd $REDIS_DIRNAME
make PREFIX=${LOCAL} install # ./configure scripts are for STALLMANS

cd $INSTANCE_TMP
echo "+ Cleaning up Redis server build artifacts"
rm -rf $REDIS_DIRNAME

cd $VIRTUAL_ENV
echo "+ Installing redis native-interface python module 'hiredis'"
bin/pip install -U hiredis
