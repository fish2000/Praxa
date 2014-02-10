#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Installing the viron template tool"
bin/pip install -U argparse argh viron
