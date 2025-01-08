from django.urls import path, include
from rest_framework.routers import DefaultRouter
from src.apis.accounts.views import CustomUserViewSet, LoginView, LogoutView

app_name = 'accounts'
router = DefaultRouter()
router.register(r'users', CustomUserViewSet)

urlpatterns = [
    path('api/', include(router.urls)),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
]
