#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Setting up a local git repository ..."
git init && git add $VIRTUAL_ENV
git commit -m "First commit for $INSTANCE_NAME (via venv-git praxime)"

