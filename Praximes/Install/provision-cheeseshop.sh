#!/usr/bin/env bash

echo "+ Installing CheeseShop essentials ..."
cd /tmp

echo ""
echo "+ Installing Django ${DJANGO_VERSION} ..."
${VIRTUAL_ENV}/bin/pip install -U django==$DJANGO_VERSION

echo ""
echo "+ Installing Cython ..."
${VIRTUAL_ENV}/bin/pip install -U Cython

echo ""
echo "+ Installing web utilities ..."
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-web-tools.txt

echo ""
echo "+ Installing PIL/Pillow and related packages ..."
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-pil.txt

echo ""
echo "+ Installing Django apps and utilities ..."
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-django.txt

# the requirements most likely updated django to whatever the latest is...
# uninstall it, then reinstall the specified version
echo ""
echo "+ Refreshing Django installation back to ${DJANGO_VERSION} ..."
#${VIRTUAL_ENV}/bin/pip install -U django==$DJANGO_VERSION
/usr/bin/yes | ${VIRTUAL_ENV}/bin/pip uninstall django
${VIRTUAL_ENV}/bin/pip install -U django==$DJANGO_VERSION