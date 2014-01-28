
echo ""
echo "+ Installing Apache Solr server ..."
cd $LOCAL_LIB
export SOLR_TARBALL_URL="http://mirror.cogentco.com/pub/apache/lucene/solr/4.5.0/solr-4.5.0.tgz"
export SOLR_TARBALL="${VIRTUAL_ENV}/solr.tgz"
test ! -r $SOLR_TARBALL && test -x `which wget` && wget $SOLR_TARBALL_URL -O $SOLR_TARBALL
test ! -r $SOLR_TARBALL && test -x `which curl` && curl $SOLR_TARBALL_URL -o $SOLR_TARBALL
test ! -r $SOLR_TARBALL && test -x `which http` && http -d $SOLR_TARBALL_URL -o $SOLR_TARBALL
if [[ -r $SOLR_TARBALL ]];
then
    mkdir -p $SOLR_ROOT && \
    cd $SOLR_ROOT && \
    tar -xvzf $SOLR_TARBALL --strip-components=1 -C $SOLR_ROOT && \
    rm $SOLR_TARBALL
fi

echo ""
echo "+ Fixing Solr stopwords config file ..."
cd $SOLR_ROOT
test ! -r $SOLR_STOPWORDS_EN && test -r $SOLR_STOPWORDS && cp $SOLR_STOPWORDS $SOLR_STOPWORDS_EN