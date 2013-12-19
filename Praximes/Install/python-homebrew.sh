#!/usr/bin/env bash
#       
#       Python Install Praxon
#       Praxa/Praximes/Install/python-homebrew.sh
#       Builds and installs the latest Python 2 release,
#           using the Homebrew package manager on Mac OS X.
#       
#       Written by Alexander Böhn -- @fish2000
#       © 2013 Objects In Space And Time, LLC. All Rights Reserved.
#       See Praxa/LICENSE.md for terms: http://git.io/h_eMZw
#       
#       Required definitions:
#           - TMP (temporary directory)
#           - USR_LOCAL ("/usr/local" or equiv)
#           - PYLIB (putative python "site-packages" dir)
#
#       Exported definitions:
#           + PYTHON_BINARY (it is the motherfucking python binary)
#

cd $TMP

echo "+ Preparing to build python using Homebrew on Mac OS X ..."

# check for the Rube
[[ `which ruby` ]] || echo "How is this going to work, with no Ruby?? Gah!"

# Is homebrew actually installed? ...
# This is the one-liner right off of http://brew.sh
if [[ ! `which brew` ]]
then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update
fi

echo "Installing python's dependencies ..."
brew install pkg-config
brew install git wget coreutils
brew install sqlite gdbm readline
brew install gnutls openssl

# install python with homebrew
brew -v install python

# PYTHON_BINARY
export PYTHON_BINARY=