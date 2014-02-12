#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Clearing filesystem gremlins..."
find $VIRTUAL_ENV -iname ".DS_Store" -print -delete
