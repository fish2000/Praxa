#!/usr/bin/env bash
#       
#       Python Install Praxon
#       Praxa/Praximes/Install/python-postinstall.sh
#       Installs additional Praxa-wide python packages.
#       
#       Written by Alexander Böhn -- @fish2000
#       © 2013 Objects In Space And Time, LLC. All Rights Reserved.
#       See Praxa/LICENSE.md for terms: http://git.io/h_eMZw
#       
#       Required definitions:
#           - PRAXIME_BASE (the Praximes directory in Praxa's tree root)
#           - USR_LOCAL ("/usr/local" or equiv)
#           - PYLIB (putative python "site-packages" dir)
#
#       Exported definitions:
#           + PYTHON_SITE_PACKAGES (the installed 'site-packages' location)
#           + PRAXA_ENV_SCRIPT (where the environment mod script goes)
#

echo "+ Determining the python site-packages directory ..."
site_packages_snippet='\
    from distutils.sysconfig import get_python_lib;\
    print get_python_lib()'
python -c "${site_packages_snippet}"
export PYTHON_SITE_PACKAGES=`python -c ${site_packages_snippet}`
echo "> ${PYTHON_SITE_PACKAGES}"

echo "+ Installing viron ..."
pip install -U argparse argh viron

# TILDE EXPANSION.
USER_BASH_SCRIPT=`user_bash_script`

cd $PRAXIME_BASE
echo "+ Installing virtualenv and virtualenvwrapper ..."
pip install -U virtualenv virtualenv-clone virtualenvwrapper
VIRTUALENVWRAPPER_BOOTSTRAP=`which virtualenvwrapper.sh`
echo "" >> ${USER_BASH_SCRIPT}
echo "" >> ${USER_BASH_SCRIPT}
echo "# Source virtualenvwrapper config script (command added by Praxa/setup.sh)" >> ${USER_BASH_SCRIPT}
echo "source ${VIRTUALENVWRAPPER_BOOTSTRAP}" >> ${USER_BASH_SCRIPT}

export PYTHON_BINARY=`which python`
export PRAXA_ENV_SCRIPT=~/.praxa-environment.sh

echo "+ Saving environment modifications to ${PRAXA_ENV_SCRIPT} ..."
DIR=${WORKON_HOME} viron ${PRAXON_TEMPLATES}/praxa-environment.sh --ignore=WORKON_HOME,PRAXIME_BASE > $PRAXA_ENV_SCRIPT
echo "+ Appending 'source ${PRAXA_ENV_SCRIPT}' at the end of ${USER_BASH_SCRIPT} ..."
echo "" >> ${USER_BASH_SCRIPT}
echo "" >> ${USER_BASH_SCRIPT}
echo "# Source Praxa's environment script (command added by Praxa/setup.sh)" >> ${USER_BASH_SCRIPT}
echo "source ${PRAXA_ENV_SCRIPT}" >> ${USER_BASH_SCRIPT}

