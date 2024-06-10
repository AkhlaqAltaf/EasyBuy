from django.urls import path
from .views import HomeView, AboutUsView, ContactUsView, ApiDocView, ApiReverse

app_name = 'website'
urlpatterns = [
    path('', HomeView.as_view(), name='home'),
    path('apidoc', ApiDocView.as_view(), name='apidoc'),
    path('contactus', ContactUsView.as_view(), name='contactus'),
    path('aboutus', AboutUsView.as_view(), name='aboutus'),
    path('api', ApiReverse.as_view(), name='api')

]
