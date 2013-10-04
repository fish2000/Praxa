echo "+ Initializing a new Django project ..."

INSTANCE=${VIRTUAL_ENV}/instance
INSTANCE_NAME=`echo "$(basename ${VIRTUAL_ENV})" | $(which sed) -e s/[^A-Za-z0-9]/_/g`
INSTANCE_MODULE="${INSTANCE}/${INSTANCE_NAME}"
INSTANCE_BIN=${VIRTUAL_ENV}/bin
INSTANCE_ADNAUSEUM=${VIRTUAL_ENV}/etc
INSTANCE_VARIANT=${VIRTUAL_ENV}/var
INSTANCE_LOGDIR=${VIRTUAL_ENV}/var/logs

mkdir -p ${INSTANCE_VARIANT}/db
mkdir -p ${INSTANCE_VARIANT}/web
mkdir -p ${INSTANCE_VARIANT}/web/static
mkdir -p ${INSTANCE_VARIANT}/web/face

#cd "${INSTANCE}/${INSTANCE_NAME}"

cd $VIRTUAL_ENV
export DJANGO_SETTINGS_MODULE="$settings"
export INSTANCE_PASSWORD=`cat .password`
export INSTANCE_PASSWORD_HASH=`md5 -q .password`

#
export PYTHONPATH=".:\
${LOCAL_PYTHON}/Django-LATEST:\
${VIRTUAL_ENV}/lib/python2.7/site-packages:\
${LOCAL_PYTHON_SITE}:\
${INSTANCE_MODULE}:\
${INSTANCE}:\
${INSTANCE}/${INSTANCE_NAME}:\
${VIRTUAL_ENV}"

cd $INSTANCE
${VIRTUAL_ENV}/bin/mezzanine-project $INSTANCE_NAME
echo ""

cd $VIRTUAL_ENV
chmod +x $INSTANCE_MANAGE

alias vbp="SIGNALQUEUE_RUNMODE=SQ_SYNC ${VIRTUAL_ENV}/bin/bpython --interactive \$INSTANCE_BPYTHON_SETTINGS"
alias vj="DJANGO_SETTINGS_MODULE=\$DJANGO_SETTINGS_MODULE ${INSTANCE_MANAGE}"

vj createdb --noinput
vj createsuperuser --noinput --username=fish --email=yodogg@gmail.com

setsuperuserpassword="\
from django.core.management import setup_environ\
;import settings\
;setup_environ(settings)\
;from django.contrib.auth.models import User\
;fish = User.objects.get(username='fish')\
;fish.set_password('${INSTANCE_PASSWORD}')\
;fish.save()\
"
${VIRTUAL_ENV}/bin/python -c "${setsuperuserpassword}"

#vj syncdb --noinput --all
#vj migrate
#mkdir -p instance/bfd2/words && vj startapp words instance/bfd2/words
vj collectstatic --noinput