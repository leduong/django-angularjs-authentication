from django.conf.urls import patterns, include, url
from django.views.generic.base import RedirectView
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('backend.views',
	url(r'^$', RedirectView.as_view(url="/public/index.html")),
	url(r'^admin/', include(admin.site.urls)),
	url(r'^', include('app.urls')))
