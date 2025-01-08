from django.urls import path
from dj_rest_auth.views import LoginView
from .views import LoginView, LogoutView, UserRegistrationView, verify_email, AccountsView

app_name = 'accounts'
urlpatterns = [
    path('',AccountsView.as_view(), name='accounts'),
    path('login/',LoginView.as_view(),name="login"),
    path('register/', UserRegistrationView.as_view(), name='register'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('verify/<str:token>/', verify_email, name='verify_email'),

]
