#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Setting bpython shell defaults ..."
export INSTANCE_BPYTHON_SETTINGS=${INSTANCE_ADNAUSEUM}/bpython-settings.py
bin/viron ${TEMPLATES}/bpython-settings.py > $INSTANCE_BPYTHON_SETTINGS

echo "+ Setting default GNU screen properties ..."
export INSTANCE_SCREENRC=${INSTANCE_ADNAUSEUM}/screenrc-virtualenv
bin/viron ${TEMPLATES}/screenrc-virtualenv > $INSTANCE_SCREENRC

echo "+ Setting default TextMate properties ..."
export INSTANCE_TM_PROPERTIES=${VIRTUAL_ENV}/.tm_properties
bin/viron ${TEMPLATES}/tm_properties > $INSTANCE_TM_PROPERTIES