#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Setting up supervisord.conf and supervisord-deploy.conf"
bin/viron ${TEMPLATES}/supervisord.conf > $SUPERVISORD_CONF
bin/viron ${TEMPLATES}/supervisord.conf > $SUPERVISORD_DEPLOY_CONF

echo "+ Setting up uwsgi.ini and uwsgi-deploy.ini"
bin/viron ${TEMPLATES}/uwsgi.ini > $UWSGI_INI
bin/viron ${TEMPLATES}/uwsgi.ini > $UWSGI_DEPLOY_INI

echo "+ Setting up development and deployment Procfiles"
bin/viron ${TEMPLATES}/Procfile > $PROCFILE_DEVELOP
bin/viron ${TEMPLATES}/Procfile > $PROCFILE_DEPLOY
if DEPLOYED; then
    ln -s $PROCFILE_DEPLOY $PROCFILE
else
    ln -s $PROCFILE_DEVELOP $PROCFILE
fi

echo "+ Setting up Makefile"
bin/viron ${TEMPLATES}/Makefile > $MAKEFILE

echo "+ Setting up redis.conf and redis-deploy.conf"
bin/viron ${TEMPLATES}/redis.conf > $INSTANCE_REDIS_CONF
bin/viron ${TEMPLATES}/redis.conf > $INSTANCE_REDIS_DEPLOY_CONF

echo "+ Preparing deploy template for ${INSTANCE_NAME}.nginx.conf"
bin/viron ${TEMPLATES}/nginx.conf > ${INSTANCE_ADNAUSEUM}/${INSTANCE_NAME}.nginx.conf

echo "+ Preparing deploy template for ${INSTANCE_NAME}.supervisord-init.sh"
bin/viron ${TEMPLATES}/supervisord-init.sh > ${INSTANCE_ADNAUSEUM}/${INSTANCE_NAME}.supervisord-init.sh

echo "+ Preparing the executable Django admin script"
DJANGO_ROOT=`bin/python -c "import django,os;print os.path.dirname(django.__file__)"`
DJANGO_ADMIN_SCRIPT="${DJANGO_ROOT}/bin/django-admin.py"
chmod +x $DJANGO_ADMIN_SCRIPT
chmod g+x $DJANGO_ADMIN_SCRIPT
export DJANGO_ADMIN="${INSTANCE_BIN}/$(basename $DJANGO_ADMIN_SCRIPT)"
test ! -r $DJANGO_ADMIN && ln -s $DJANGO_ADMIN_SCRIPT $DJANGO_ADMIN

echo "+ Initializing the virtualenv's ipython profile"
bin/pip install -U ipython && \
    bin/ipython profile create --profile-dir=${INSTANCE_IPYTHON_PROFILE}

