#!/usr/bin/env bash

echo "+ Initializing project template ..."
cd $VIRTUAL_ENV
bin/viron ${TEMPLATES}/gitignore > "${VIRTUAL_ENV}/.gitignore"
MANAGE_PY="${VIRTUAL_ENV}/manage.py"
bin/viron ${TEMPLATES}/django-manage.py > $MANAGE_PY
chmod +x $MANAGE_PY

bin/viron ${TEMPLATES}/django-settings.py > "${INSTANCE_MODULE}/settings.py"
bin/viron ${TEMPLATES}/urls.py > "${INSTANCE_MODULE}/urls.py"
bin/viron ${TEMPLATES}/wsgi.py > "${INSTANCE_MODULE}/wsgi.py"

bin/viron ${TEMPLATES}/gunicorn-devel.py > "${INSTANCE_ADNAUSEUM}/gunicorn-devel.py"
bin/viron ${TEMPLATES}/gunicorn-debug.py > "${INSTANCE_ADNAUSEUM}/gunicorn-debug.py"

INIT_PY_SRC=`bin/viron ${TEMPLATES}/init.py`
echo $INIT_PY_SRC > "${INSTANCE}/__init__.py"
echo $INIT_PY_SRC > "${INSTANCE_MODULE}/__init__.py"