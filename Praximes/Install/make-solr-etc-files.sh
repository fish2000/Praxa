#!/usr/bin/env bash

cd $VIRTUAL_ENV
echo "+ Generating initial Solr schema ..."
eval "vj build_solr_schema -f ${SOLR_SCHEMA}"

echo "+ Copying SolrLire schema patch to ${SOLR_LIRE_SCHEMA_PATCH} ..."
bin/viron ${TEMPLATES}/solr-lire-schema-fields.patch > $SOLR_LIRE_SCHEMA_PATCH
if [[ -r $SOLR_LIRE_SCHEMA_PATCH ]]; then
    echo "+ NOTE: patch content was saved to ${SOLR_LIRE_SCHEMA_PATCH}"
    echo "+ NOTE: the Solr schema has not been patched automatically by Praxa"
    echo "+ NOTE: use \`make schema\` to generate and patch a new schema file"
else
    echo "- ERROR: patch content could not be saved"
fi

echo "+ Symlinking Solr schema and config files into etc/ ..."
[[ -r $SOLR_SCHEMA ]] && ln -s "${SOLR_SCHEMA}" "${INSTANCE_ADNAUSEUM}/solr-schema.xml"
[[ -r $SOLR_CONFIG ]] && ln -s "${SOLR_CONFIG}" "${INSTANCE_ADNAUSEUM}/solr-config.xml"