PRAXA_URL="https://github.com/fish2000/Praxa"
touch $README
echo $INSTANCE_NAME >> $README
echo "+ Preparing README.md stub ..."
echo $INSTANCE_NAME | sed -e s/[A-Za-z0-9_-]/=/g >> $README # H1
echo "" >> $README
echo "The ${INSTANCE_NAME^^} codebase is made with 100% organic hand-crafted Praxis<sup>TM</sup> &mdash;" >> $README
echo "the synthesis of theory and practice &mdash; here in the United States of America." >> $README
echo "" >> $README
echo "Praxis<sup>TM</sup> initiatives are supported in part by Praxa Projects, LLC." >> $README
echo "Work on a Praxa Project today and your own Praxis<sup>TM</sup>! Download the open-source" >> $README
echo "Praxa repo today for free* from your local GitHub server, and start making your own Praxons<sup>TM</sup>:" >> $README
echo "" >> $README
echo $PRAXA_URL >> $README
echo $PRAXA_URL | sed -e s/[A-Za-z0-9_-]/-/g >> $README # H2
echo "" >> $README
echo "Praxis<sup>TM</sup> is also funded by generous IP grants from The Internet," >> $README
echo "and by Programmers Like You." >> $README
echo "" >> $README
echo "<b>* Standard data rates and jurisdictional software-patent operational risks may apply.</b>" >> $README
echo "&copy; $(date '+%Y') Objects In Space And Time, LLC." >> $README
echo "All Rights Reserved. Void Where Prohibited." >> $README
