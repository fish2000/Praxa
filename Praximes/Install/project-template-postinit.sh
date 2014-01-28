#!/usr/bin/env bash

echo "+ Setting up supervisord.conf ..."
cd $VIRTUAL_ENV
bin/viron ${TEMPLATES}/supervisord.conf > $SUPERVISORD_CONF

echo "+ Setting up Procfile ..."
cd $VIRTUAL_ENV
bin/viron ${TEMPLATES}/Procfile > $PROCFILE

echo "+ Setting up redis ..."
cd $VIRTUAL_ENV
bin/viron ${TEMPLATES}/redis.conf > $INSTANCE_REDIS_CONF

echo "+ Preparing the executable Django admin script ..."
cd $VIRTUAL_ENV
DJANGO_ROOT=`bin/python -c "import django,os;print os.path.dirname(django.__file__)"`
DJANGO_ADMIN_SCRIPT="${DJANGO_ROOT}/bin/django-admin.py"
chmod +x $DJANGO_ADMIN_SCRIPT
chmod g+x $DJANGO_ADMIN_SCRIPT
export DJANGO_ADMIN="${INSTANCE_BIN}/$(basename $DJANGO_ADMIN_SCRIPT)"
test ! -r $DJANGO_ADMIN && ln -s $DJANGO_ADMIN_SCRIPT $DJANGO_ADMIN
