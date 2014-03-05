#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Clearing filesystem gremlins..."
DEPLOYED || find $VIRTUAL_ENV -iname ".DS_Store" -print -delete
