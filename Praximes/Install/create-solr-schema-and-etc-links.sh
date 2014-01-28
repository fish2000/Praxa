#!/usr/bin/env bash

echo ""
echo "+ Generating initial Solr schema ..."
cd $VIRTUAL_ENV
eval "vj build_solr_schema -f ${SOLR_SCHEMA}"

echo "+ Symlinking schema.xml and solrconfig.xml from Solr config directory to etc/ ..."
ln -s "${SOLR_SCHEMA}" "${INSTANCE_ADNAUSEUM}/solr-schema.xml"
ln -s "${SOLR_CONFIG}" "${INSTANCE_ADNAUSEUM}/solr-config.xml"