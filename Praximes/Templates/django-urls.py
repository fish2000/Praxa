
from django.conf import settings
from django.conf.urls import patterns, include, url, static
from django.contrib import admin

admin.autodiscover()

urlpatterns = patterns('',

    url(r'^admin/',
        include(admin.site.urls)),

)


from django.conf import settings
if not settings.DEPLOYED:
    
    urlpatterns += static(
        settings.MEDIA_URL,
        document_root=settings.MEDIA_ROOT)
    
    urlpatterns += static(
        settings.STATIC_URL,
        document_root=settings.STATIC_ROOT)
