
cd $LOCAL_LIB
echo "+ Installing Apache Solr server ..."
# SOLR_VERSION="4.6.0"
SOLR_VERSION="4.8.1"
SOLR_DIRNAME="solr-${SOLR_VERSION}"
SOLR_TARBALL_NAME="${SOLR_DIRNAME}.tgz"
SOLR_TARBALL_URL="http://mirror.cogentco.com/pub/apache/lucene/solr/${SOLR_VERSION}/${SOLR_TARBALL_NAME}"

fetch_and_expand $SOLR_TARBALL_URL $SOLR_ROOT

echo ""
echo "+ Fixing Solr stopwords config file ..."
cd $SOLR_ROOT
test ! -r $SOLR_STOPWORDS_EN && test -r $SOLR_STOPWORDS && cp $SOLR_STOPWORDS $SOLR_STOPWORDS_EN