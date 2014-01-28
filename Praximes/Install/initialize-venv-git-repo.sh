#!/usr/bin/env bash

echo "+ Setting up a local git repository ..."
cd $VIRTUAL_ENV
git init
git add $VIRTUAL_ENV
git status
git commit -m "First commit for $INSTANCE_NAME (via praxime by virtualenvwrapper hook)."
echo ""

