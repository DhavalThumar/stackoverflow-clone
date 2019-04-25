"""
Definition of urls for stackoverflow.
"""

from datetime import datetime
from django.conf.urls import url
import django.contrib.auth.views

import app.forms
import app.views

# Uncomment the next lines to enable the admin:
# from django.conf.urls import include
# from django.contrib import admin
# admin.autodiscover()
app_name = 'app'

urlpatterns = [
    # Examples:
    url(r'^$', app.views.viewQuestion, name='home'),
    url(r'^que$',
        app.views.viewQuestion, name='viewquestion'),
    url(r'^que/create$',
        app.views.postQuestion, name='createquestion'),
    url(r'^que/(?P<id>\d+)/$',
        app.views.updateQuestion, name='updatequestion'),
    url(r'^que/(?P<id>\d+)/ans$',
        app.views.postAnswer, name='answer'),
    url(r'^signup/$', app.views.signup, name='signup'),
    url(r'^login/$',
        django.contrib.auth.views.login,
        {
            'template_name': 'app/login.html',
            'authentication_form': app.forms.BootstrapAuthenticationForm,
            'extra_context':
            {
                'title': 'Log in',
                'year': datetime.now().year,
            }
        },
        name='login'),
    url(r'^logout$',
        django.contrib.auth.views.logout,
        {
            'next_page': '/',
        },
        name='logout'),
    

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
]
