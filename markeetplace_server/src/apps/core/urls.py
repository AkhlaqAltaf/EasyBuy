from django.urls import path
from . import views

app_name = 'core'


urlpatterns = [
    path('', views.FrontPageView.as_view(), name="home"),
    path('contact-us/', views.contactpage, name="contact"),
]
