from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    (r'^recent/$', 'main.views.recent'),
	(r'^upload/$', 'main.views.upload'),
	(r'^update_art_piece/(\d+)/$', 'main.views.update_art_piece'),
	(r'^art_piece/(\d+)/$', 'main.views.art_piece'),
    # Example:
    # (r'^artwalk_site/', include('artwalk_site.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # (r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # (r'^admin/', include(admin.site.urls)),
)
