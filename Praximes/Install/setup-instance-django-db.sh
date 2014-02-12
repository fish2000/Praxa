#!/usr/bin/env bash

cd $VIRTUAL_ENV
if [[ -r $INSTANCE_DEVELOPMENT_DB ]]; then
    # clear out existant sqlite file
    echo "+ Deleting existing dev database: ${INSTANCE_DEVELOPMENT_DB}"
    rm -f $INSTANCE_DEVELOPMENT_DB
fi

echo "+ Creating a Django dev database file [SQLite]"
eval "vj syncdb --migrate --noinput"

echo "+ Creating a new Django superuser"
echo ">>> username: fish"
echo ">>> password: ${INSTANCE_PASSWORD}"
eval "vj createsuperuser --noinput --username=fish --email=yodogg@gmail.com"

setsuperuserpassword="\
from django.contrib.auth.models import User\
;(fish, made) = User.objects.get_or_create(username='fish')\
;made and fish.set_password('${INSTANCE_PASSWORD}')\
;made and fish.save()\
"

echo "+ Setting the password for the Django superuser"
${INSTANCE_BIN}/python -c "${setsuperuserpassword}"

echo "+ Collecting all static files in the instance subtree"
eval "vj collectstatic --noinput > /dev/null"
