#!/usr/bin/env bash

echo "+ Clearing filesystem gremlins..."
find $VIRTUAL_ENV -iname ".DS_Store" -print -delete
echo ""
