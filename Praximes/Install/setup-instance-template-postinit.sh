#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Setting up supervisord.conf and supervisord-deploy.conf ..."
bin/viron ${TEMPLATES}/supervisord.conf > $SUPERVISORD_CONF
bin/viron ${TEMPLATES}/supervisord.conf > $SUPERVISORD_DEPLOY_CONF

echo "+ Setting up uwsgi.ini and uwsgi-deploy.ini ..."
bin/viron ${TEMPLATES}/uwsgi.ini > $UWSGI_INI
bin/viron ${TEMPLATES}/uwsgi.ini > $UWSGI_DEPLOY_INI

echo "+ Setting up development and deployment Procfiles ..."
bin/viron ${TEMPLATES}/Procfile > $PROCFILE_DEVELOP
bin/viron ${TEMPLATES}/Procfile > $PROCFILE_DEPLOY
if [[ $DEPLOYED ]]; then
    ln -s $PROCFILE_DEPLOY $PROCFILE
else
    ln -s $PROCFILE_DEVELOP $PROCFILE
fi

echo "+ Setting up Makefile ..."
bin/viron ${TEMPLATES}/Makefile > $MAKEFILE

echo "+ Setting up redis.conf and redis-deploy.conf ..."
bin/viron ${TEMPLATES}/redis.conf > $INSTANCE_REDIS_CONF
bin/viron ${TEMPLATES}/redis.conf > $INSTANCE_REDIS_DEPLOY_CONF

echo "+ Preparing the executable Django admin script ..."
DJANGO_ROOT=`bin/python -c "import django,os;print os.path.dirname(django.__file__)"`
DJANGO_ADMIN_SCRIPT="${DJANGO_ROOT}/bin/django-admin.py"
chmod +x $DJANGO_ADMIN_SCRIPT
chmod g+x $DJANGO_ADMIN_SCRIPT
export DJANGO_ADMIN="${INSTANCE_BIN}/$(basename $DJANGO_ADMIN_SCRIPT)"
test ! -r $DJANGO_ADMIN && ln -s $DJANGO_ADMIN_SCRIPT $DJANGO_ADMIN

echo "+ Preparing README.md stub ..."
# This next bit here is how bash does markdown
export INSTANCE_H1=`echo $INSTANCE_NAME | sed -e s/[A-Za-z0-9_-]/=/g`
export YEAR=`date '+%Y'`
bin/viron ${TEMPLATES}/README.stub.md > $README
