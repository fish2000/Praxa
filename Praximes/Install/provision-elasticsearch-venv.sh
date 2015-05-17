
cd $LOCAL_LIB
echo "+ Installing ElasticSearch ..."
ELASTICSEARCH_VERSION="1.5.2"
ELASTICSEARCH_DIRNAME="elasticsearch-${ELASTICSEARCH_VERSION}"
ELASTICSEARCH_ZIPWAD_NAME="${ELASTICSEARCH_DIRNAME}.zip"
ELASTICSEARCH_URL="https://download.elastic.co/elasticsearch/elasticsearch/${ELASTICSEARCH_ZIPWAD_NAME}"

fetch_and_expand $ELASTICSEARCH_URL $ES_HOME

cd $VENV
[[ -x ${ES_HOME}/bin/elasticsearch ]] && ln -s ${ES_HOME}/bin/elasticsearch bin/elasticsearch