#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Setting up supervisord.conf ..."
bin/viron ${TEMPLATES}/supervisord.conf > $SUPERVISORD_CONF

echo "+ Setting up Procfile ..."
bin/viron ${TEMPLATES}/Procfile > $PROCFILE

echo "+ Setting up Makefile ..."
bin/viron ${TEMPLATES}/Makefile > $MAKEFILE

echo "+ Setting up redis ..."
bin/viron ${TEMPLATES}/redis.conf > $INSTANCE_REDIS_CONF

echo "+ Preparing the executable Django admin script ..."
DJANGO_ROOT=`bin/python -c "import django,os;print os.path.dirname(django.__file__)"`
DJANGO_ADMIN_SCRIPT="${DJANGO_ROOT}/bin/django-admin.py"
chmod +x $DJANGO_ADMIN_SCRIPT
chmod g+x $DJANGO_ADMIN_SCRIPT
export DJANGO_ADMIN="${INSTANCE_BIN}/$(basename $DJANGO_ADMIN_SCRIPT)"
test ! -r $DJANGO_ADMIN && ln -s $DJANGO_ADMIN_SCRIPT $DJANGO_ADMIN
