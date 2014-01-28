#!/usr/bin/env bash

echo "+ Initializing a Django SQLite development database ..."
eval "vj syncdb --migrate --noinput"

echo "+ Creating a default superuser for use the Django admin"
echo ">>> username: fish"
echo ">>> password: ${INSTANCE_PASSWORD}"
eval "vj createsuperuser --noinput --username=fish --email=yodogg@gmail.com"

setsuperuserpassword="\
from django.core.management import setup_environ\
;import settings\
;setup_environ(settings)\
;from django.contrib.auth.models import User\
;fish = User.objects.get(username='fish')\
;fish.set_password('${INSTANCE_PASSWORD}')\
;fish.save()\
"
${INSTANCE_BIN}/python -c "${setsuperuserpassword}"

echo "+ Preparing static files for access ..."
eval "vj collectstatic --noinput"
