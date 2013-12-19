DJANGO_GITHUB_REPO="git://github.com/django/django.git"
DJANGO_GITHUB_ZIPFILE="https://nodeload.github.com/django/django/zipball/master"

cd $VIRTUAL_ENV
bin/pip uninstall django --yes

echo "+ Installing Django from the official GitHub repo:"
echo "+ ${DJANGO_GITHUB_REPO}"
cd /tmp

#`which git` clone $DJANGO_GITHUB_REPO head
#`which git` archive --remote=${DJANGO_GITHUB_REPO} master
#DJANGO_COMMIT_HASH=$(git log -1 --no-decorate --abbrev-commit --no-notes --oneline --format="%h")
#mv ./head/ ${INSTANCE}/Django-master-${DJANGO_COMMIT_HASH}

if [[ ! -r ${INSTANCE_CACHE}/django-master.zip ]]
then
    if [[ ! -r /tmp/django-master.zip ]]
    then
        echo "+ Downloading archive: ${DJANGO_GITHUB_ZIPFILE}"
        curl $DJANGO_GITHUB_ZIPFILE -o "${INSTANCE_CACHE}/django-master.zip"
        DJANGO_ZIPFILE=${INSTANCE_CACHE}/django-master.zip
    else
        echo "+ Using cached archive: /tmp/django-master.zip"
        DJANGO_ZIPFILE=/tmp/django-master.zip
else
    echo "+ Using cached archive: ${INSTANCE_CACHE}/django-master.zip"
    DJANGO_ZIPFILE=${INSTANCE_CACHE}/django-master.zip
fi

DJANGO_GITHUB_DIRECTORY=`$(which zipinfo) -1 $DJANGO_ZIPFILE | head -1`
DJANGO_COMMIT_HASH=`echo $DJANGO_GITHUB_DIRECTORY | $(which sed) -E "s/([A-Za-z]*)-([A-Za-z]*)-([0-9a-z]*)\//\3/g"`
unzip /tmp/django-master.zip -d $LOCAL_PYTHON
mv "${LOCAL_PYTHON}/${DJANGO_GITHUB_DIRECTORY}" "${LOCAL_PYTHON}/Django-master-${DJANGO_COMMIT_HASH}"

if [[ -L "${LOCAL_PYTHON}/Django-LATEST" ]]
then
    echo "+ Unlinking old Django codebase from ${LOCAL_PYTHON}/Django-LATEST"
    rm "${LOCAL_PYTHON}/Django-LATEST"
fi

echo "+ Linking the fresh clone to ${LOCAL_PYTHON}/Django-LATEST"
ln -s ${LOCAL_PYTHON}/Django-master-${DJANGO_COMMIT_HASH} ${LOCAL_PYTHON}/Django-LATEST

if [[ $PYTHONPATH =~ "Django-LATEST" ]]
then
    echo ""
else
    export PYTHONPATH="${LOCAL_PYTHON}/Django-LATEST:${PYTHONPATH}"
    echo ""
fi


