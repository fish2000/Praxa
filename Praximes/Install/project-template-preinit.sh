#!/usr/bin/env bash

echo "+ Setting bpython shell defaults ..."
cd $VIRTUAL_ENV
export INSTANCE_BPYTHON_SETTINGS=${INSTANCE_ADNAUSEUM}/bpython-settings.py
bin/viron ${TEMPLATES}/bpython-settings.py > $INSTANCE_BPYTHON_SETTINGS

echo "+ Setting default GNU screen properties ..."
cd $VIRTUAL_ENV
export INSTANCE_SCREENRC=${INSTANCE_ADNAUSEUM}/screenrc-virtualenv
bin/viron ${TEMPLATES}/screenrc-virtualenv > $INSTANCE_SCREENRC

echo "+ Setting default TextMate properties ..."
cd $VIRTUAL_ENV
export INSTANCE_TM_PROPERTIES=${VIRTUAL_ENV}/.tm_properties
bin/viron ${TEMPLATES}/tm_properties > $INSTANCE_TM_PROPERTIES