#!/usr/bin/env bash

echo "+ Setting up development environment bash functions ..."
cd $VIRTUAL_ENV

function vcd () {
    HOME=$VIRTUAL_ENV CDPATH="${VIRTUAL_ENV}:${VIRTUAL_ENV}/local:${VIRTUAL_ENV}/var:/tmp:${CDPATH}" eval "cd $@"
}

function vbp () {
    SIGNALQUEUE_RUNMODE=SQ_SYNC ${INSTANCE_BIN}/bpython --interactive $INSTANCE_BPYTHON_SETTINGS
}

function vj () {
    DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE eval "${DJANGO_ADMIN} $@"
}

function vrun () {
    DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE eval "${SUPERVISORD} $@"
}

function vsuper () {
    DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE eval "${SUPERVISORCTL} $@"
}

function vmate () {
    DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE eval "mate ${VIRTUAL_ENV} $@"
}

function vforeman () {
    DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE eval "${HONCHO} start $@"
}

PS1="\[\033[01;33m\]($(basename ${VIRTUAL_ENV}))\[\033[00m\] ${_OLD_VIRTUAL_PS1}"