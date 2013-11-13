#!/usr/bin/env bash
#set -x

ORIG_PREFIX_FILE="lib/python2.7/orig-prefix.txt"
ORIG_PREFIX=$(cat ${ORIG_PREFIX_FILE})
OLD_VERSION=$(echo $ORIG_PREFIX | awk -F/ '{ print $6 }')
PY_VERSION=$(/usr/local/bin/python -c 'import sys; print sys.version.split(" ")[0]')
NEW_PREFIX=$(echo $ORIG_PREFIX | sed "s#${OLD_VERSION}#${PY_VERSION}#g")

echo "ORIG PREFIX: ${ORIG_PREFIX}"
echo "NEW PREFIX: ${NEW_PREFIX}"

echo $NEW_PREFIX > $ORIG_PREFIX_FILE

function relink () {
    file=$1
    dir=`dirname $file`
    bs=`basename $file`
    if [ ! -e `readlink -n $file` ]; then
        [[ $dir = "." ]] && newfile="${NEW_PREFIX}/$(echo $bs | sed 's#.##')" || newfile="${NEW_PREFIX}/$(echo $dir | sed 's#./##')/${bs}"
        #echo $newfile
        if [ -e $newfile ]; then
            rm $file && ln -s $newfile $file
        fi
    fi
}

cd $VIRTUAL_ENV

bad_links=$(/usr/local/bin/gfind . -type l -exec test ! -e {} \; -print)
echo "BAD LINKS:"
for bad_link in $bad_links; do
    echo $bad_link
done

for bad_link in $bad_links; do
    #echo "BAD LINK: ${bad_link}"
    relink $bad_link
done