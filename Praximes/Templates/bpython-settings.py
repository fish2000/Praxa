
## timer
import time
t1 = time.time()

## setup django
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', '${INSTANCE_SAFE_NAME}.settings')

from django.conf import settings
from django.contrib.auth.models import User
fish = User.objects.get(username='fish')

## web scraping stuff
from bs4 import BeautifulSoup
import os, sys, re, urllib2, requests, xerox

## how long... has this been... going on?
t2 = time.time()
dt = str((t2-t1)*1.00)
dtout = dt[:(dt.find(".")+4)]
print ">>> VirtualEnv ${INSTANCE_NAME} Praxon loaded in %ssec from ${VIRTUAL_ENV}" % dtout



