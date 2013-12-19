DJANGO_SVN_REPO="http://code.djangoproject.com/svn/django/trunk/"

cd $VIRTUAL_ENV
bin/pip uninstall django --yes

echo "+ Installing Django from SVN repo:"
echo "+ ${DJANGO_SVN_REPO}"
cd /tmp
svn export $DJANGO_SVN_REPO
DJANGO_SVN_TAG=`svn info ${DJANGO_SVN_REPO} | awk '{ if ($1 ~ /^Revision/) print $2 }'`
mv ./trunk/ ${LOCAL_PYTHON}/Django-SVN-${DJANGO_SVN_TAG}

if [[ -L "${LOCAL_PYTHON}/Django-LATEST" ]]
then
    echo "+ Unlinking old Django codebase from ${INSTANCE}/Django-LATEST"
    rm "${LOCAL_PYTHON}/Django-LATEST"
fi

ln -s ${LOCAL_PYTHON}/Django-SVN-${DJANGO_SVN_TAG} ${LOCAL_PYTHON}/Django-LATEST
export PYTHONPATH=${LOCAL_PYTHON}/Django-LATEST:${PYTHONPATH}
echo ""
