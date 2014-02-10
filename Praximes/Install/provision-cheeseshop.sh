#!/usr/bin/env bash

cd /tmp
echo "+ Installing CheeseShop essentials"
echo "+ Installing Cython:"
${VIRTUAL_ENV}/bin/pip install -U Cython

echo "+ Installing numpy:"
${VIRTUAL_ENV}/bin/pip install -U numpy

echo "+ Installing numexpr:"
${VIRTUAL_ENV}/bin/pip install -U numexpr

echo "+ Installing virtualenv utilities:"
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-env-tools.txt

echo "+ Installing web utilities:"
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-web-tools.txt

echo "+ Installing MATH POWER:"
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-math.txt

echo "+ Installing PIL/Pillow and related packages:"
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-pil.txt

echo "+ Installing Django apps and utilities:"
${VIRTUAL_ENV}/bin/pip install -U -r ${PRAXIME_BASE}/requirements-django.txt

# the requirements most likely updated django to whatever the latest is...
# uninstall it, then reinstall the specified version
# echo "+ Refreshing Django installation back to ${DJANGO_VERSION}:"
# ${VIRTUAL_ENV}/bin/pip install -U django==$DJANGO_VERSION

echo "+ Installing Django: ${DJANGO_VERSION}"
${VIRTUAL_ENV}/bin/pip install -U django==$DJANGO_VERSION
