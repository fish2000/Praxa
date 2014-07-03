#!/usr/bin/env bash
#set -x

ORIG_PREFIX_FILE="lib/python2.7/orig-prefix.txt"
ORIG_PREFIX=$(cat ${ORIG_PREFIX_FILE})

#OLD_VERSION=$(echo $ORIG_PREFIX | awk -F/ '{ print $6 }')
#PY_VERSION="$(/usr/local/bin/python -c 'import sys; print sys.version.split(" ")[0]')_2"
#PY_VERSION=$(basename $(greadlink -f `brew --prefix python`))
#NEW_PREFIX=$(echo $ORIG_PREFIX | sed "s#${OLD_VERSION}#${PY_VERSION}#g")

NEW_PREFIX=$(/usr/local/bin/python -c 'import sys; print sys.prefix')

if [[ $ORIG_PREFIX == $NEW_PREFIX ]]; then
    echo "- Linked python version is current"
    return 127
fi

echo "OLD PREFIX: ${ORIG_PREFIX}"
echo "NEW PREFIX: ${NEW_PREFIX}"

function __relink__ () {
    file=$1
    dir=`dirname $file`
    bs=`basename $file`
    printf "\tTarget: \t${file}\n"
    if [ ! -e `readlink -n $file` ]; then
        [[ $dir = "." ]] && newfile="${NEW_PREFIX}/$(echo $bs | sed 's#.##')" || newfile="${NEW_PREFIX}/$(echo $dir | sed 's#./##')/${bs}"
        printf "\tSource: \t${newfile}\n"
        if [ -e $newfile ]; then
            rm $file && ln -s $newfile $file
        fi
    fi
}

cd $VIRTUAL_ENV

bad_links=$(/usr/local/bin/gfind . -type l -exec test ! -e {} \; -print)
how_bad=${#bad_links[@]}

echo "+ Relinking ${how_bad} bad links:"
for bad_link in $bad_links; do
    echo $bad_link
done

echo ""
for bad_link in $bad_links; do
    __relink__ $bad_link
    echo ""
done

echo "+ Writing new prefix to ${ORIG_PREFIX_FILE}"
echo $NEW_PREFIX > $ORIG_PREFIX_FILE

echo "+ Committing changes"
git addremove $VIRTUAL_ENV && git commit -m "New python version (via update-venv-symlinks praxon)"

return 0