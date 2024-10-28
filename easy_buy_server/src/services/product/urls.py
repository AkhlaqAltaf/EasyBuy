# urls.py
from django.urls import path
from django.conf.urls.static import static

from core import settings
from .views import CategoriesListView, ProductListView, OrderCreateView, OrderRetrieveUpdateDestroyView
app_name = 'product'
urlpatterns = [
    path('products/', ProductListView.as_view(), name='product-list'),
    path('categories/', CategoriesListView.as_view(), name='category-list'),
    path('orders/', OrderCreateView.as_view(), name='order-create'),
    path('orders/<int:pk>/', OrderRetrieveUpdateDestroyView.as_view(), name='order-detail'),
]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)