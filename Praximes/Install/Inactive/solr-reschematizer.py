
import sys, os, uuid, tempfile
from django.core.management import call_command

def main():
    
    # create /tmp/log with default bitmask of 0777
    os.makedirs('/tmp/log')
    
    # 

def reschematize(solr_schema=None):
    default_schema = "/Users/fish/Dropbox/local-instance-packages/apache-solr-3.3.0/example/solr/conf/schema.xml"
    
    if solr_schema is None:
        solr_schema = os.environ.get('SOLR_SCHEMA', default_schema)
    tmpid = uuid.uuid4().hex
    tmpold = "/tmp/solr-schema-old-%s.xml" % tmpid
    tmpnew = "/tmp/solr-schema-new-%s.xml" % tmpid

if __name__ == '__main__':
    main()

