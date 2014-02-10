#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Initializing project template ..."
MANAGE_PY="${VIRTUAL_ENV}/manage.py"
GITIGNORE="${VIRTUAL_ENV}/.gitignore"

set -x
bin/viron ${TEMPLATES}/gitignore > $GITIGNORE
bin/viron ${TEMPLATES}/django-manage.py > $MANAGE_PY && chmod +x $MANAGE_PY
bin/viron ${TEMPLATES}/django-settings.py > "${INSTANCE_MODULE}/settings.py"
bin/viron ${TEMPLATES}/urls.py > "${INSTANCE_MODULE}/urls.py"
bin/viron ${TEMPLATES}/wsgi.py > "${INSTANCE_MODULE}/wsgi.py"
bin/viron ${TEMPLATES}/gunicorn-devel.py > "${INSTANCE_ADNAUSEUM}/gunicorn-devel.py"
bin/viron ${TEMPLATES}/gunicorn-debug.py > "${INSTANCE_ADNAUSEUM}/gunicorn-debug.py"
bin/viron ${TEMPLATES}/init.py > "${INSTANCE}/__init__.py"
bin/viron ${TEMPLATES}/init.py > "${INSTANCE_MODULE}/__init__.py"
set +x