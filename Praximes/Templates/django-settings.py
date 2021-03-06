# Django settings for the $INSTANCE_NAME project.

import platform, os, hashlib
virtualpath = lambda *pths: os.path.join('$VIRTUAL_ENV', *pths)
hasher = lambda token: hashlib.sha256(token).hexdigest()

secret = "${INSTANCE_PASSWORD_HASH}"
if os.path.isfile(virtualpath('.password')):
    with open(virtualpath('.password'), 'rb') as passfile:
        password = passfile.read()
        secret = hasher(password)

BASE_HOSTNAME = platform.node().lower()
DEPLOYED = not BASE_HOSTNAME.endswith('.local')

DEBUG = not DEPLOYED
TEMPLATE_DEBUG = DEBUG
ADMINS = ()
MANAGERS = ADMINS
SECRET_KEY = secret

if DEPLOYED:
    ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': virtualpath('var', 'db', 'dev.db'),
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': '',
    }
}

memcache = {
    'BACKEND': 'django.core.cache.backends.memcached.PyLibMCCache',
    'LOCATION': virtualpath('var', 'run', 'memcached.sock'),
    'KEY_PREFIX': '${INSTANCE_SAFE_NAME}' }

localmemory = {
    'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
    'LOCATION': '${INSTANCE_SAFE_NAME}' }

CACHES = {
    'default': DEPLOYED and memcache or localmemory
}

if DEPLOYED:
    CACHE_MIDDLEWARE_SECONDS = 60
    CACHE_MIDDLEWARE_KEY_PREFIX = "${INSTANCE_SAFE_NAME}_cache"
    SESSION_ENGINE = "django.contrib.sessions.backends.cached_db"

TIME_ZONE = 'America/New_York'
LANGUAGE_CODE = 'en-us'
SITE_ID = 1
USE_I18N = False
USE_L10N = False
USE_TZ = False

MEDIA_ROOT = virtualpath('var', 'web', 'face')
MEDIA_URL = '/face/'
TEMPLATE_DIRS = ()
STATIC_ROOT = virtualpath('var', 'web', 'static')
STATIC_URL = '/static/'
STATICFILES_DIRS = ()
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
    'django.template.loaders.eggs.Loader',
)

MIDDLEWARE_CLASSES = DEPLOYED and (
    # Caching is enabled.
    # N.B. The order of these matters, evidently
    'django.middleware.cache.UpdateCacheMiddleware',
    'django.middleware.gzip.GZipMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.cache.FetchFromCacheMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
) or (
    # Caching is disabled.
    'django.middleware.gzip.GZipMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
)

TEMPLATE_CONTEXT_PROCESSORS = (
    "django.contrib.auth.context_processors.auth",
    "django.core.context_processors.request",
    "django.core.context_processors.debug",
    #"django.core.context_processors.i18n", this is AMERICA
    "django.core.context_processors.media",
    "django.core.context_processors.static",
)

ROOT_URLCONF = '${INSTANCE_SAFE_NAME}.urls'
WSGI_APPLICATION = '${INSTANCE_SAFE_NAME}.wsgi.application'

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # 'django_admin_bootstrapped.bootstrap3',
    # 'django_admin_bootstrapped',
    'django.contrib.admin',
    
    'haystack',
    'south',
    'gunicorn',
    'imagekit',
)

HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.solr_backend.SolrEngine',
        'URL': 'http://127.0.0.1:8983/solr',
    },
}

LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'root': {
        'level': 'INFO',
        'handlers': ['console'],
    },
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        },
    },
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose'
        }
    },
    'loggers': {
        'django.db.backends': {
            'level': 'ERROR',
            'handlers': ['console'],
            'propagate': False,
        },
    },
}
