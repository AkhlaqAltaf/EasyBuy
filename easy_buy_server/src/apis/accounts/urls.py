from django.urls import path, include
from dj_rest_auth.views import LogoutView, PasswordChangeView, LoginView
from .views import UserCreateView, VerifyEmailView, CustomLoginView

app_name = 'accounts'
urlpatterns = [
    path('register/', UserCreateView.as_view(), name='register'),
    path('login/', CustomLoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='rest_logout'),
    path('password/change/', PasswordChangeView.as_view(), name='rest_password_change'),
    path('verify-email/', VerifyEmailView.as_view(), name='verify-email'),

]
