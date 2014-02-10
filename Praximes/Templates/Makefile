
# SOLR
SOLR_ROOT = local/lib/solr/example
SOLR_LIB = $(SOLR_ROOT)/solr/lib
SOLR_STOPWORDS_LANG = $(SOLR_CONF)/lang/stopwords_en.txt
SOLR_STOPWORDS_COPY_TO = $(SOLR_STOPWORDS_LANG) $(SOLR_STOPWORDS_EN)

all: update build

# SOLR_SCHEMA gets assigned when `env_preinit` runs
schema-generate: $(SOLR_STOPWORDS_COPY_TO)
		bin/python manage.py build_solr_schema -f $(SOLR_SCHEMA) --verbosity=2

schema-patch: $(SOLR_STOPWORDS_COPY_TO)
		patch -p1 schema.xml \
			-d $(shell dirname `readlink etc/solr-schema.xml`) \
				< etc/solr-lire-schema-fields.patch

schema: schema-generate schema-patch

# There are basically two of this next rule --
# I am not at all sure which `stopwords.txt` file
# has to be where, for Solr to not freak out
# and bail when you tell it to launch.
$(SOLR_STOPWORDS_LANG): $(SOLR_STOPWORDS)
		cp $(SOLR_STOPWORDS) $(SOLR_STOPWORDS_LANG)

$(SOLR_STOPWORDS_EN): $(SOLR_STOPWORDS)
		cp $(SOLR_STOPWORDS) $(SOLR_STOPWORDS_EN)

clean: clean-pyc

distclean: clean-schema clean-all-pyc

clean-schema:
		rm -f $(SOLR_SCHEMA) && touch $(SOLR_SCHEMA)

clean-pyc:
		find $(INSTANCE) -name \*.pyc -print -delete

clean-all-pyc:
		find $(VIRTUAL_ENV) -name \*.pyc -print -delete

.PHONY: update build schema all distclean clean
