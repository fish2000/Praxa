#!/usr/bin/env bash

echo "+ Installing python modules for viron ..."
cd $VIRTUAL_ENV
bin/pip install -U pysqlite
bin/pip install -U argparse argh viron
