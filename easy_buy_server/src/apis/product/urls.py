# urls.py
from django.urls import path
from .views import ProductListView, OrderCreateView, OrderRetrieveUpdateDestroyView
app_name = 'product'
urlpatterns = [
    path('products/', ProductListView.as_view(), name='product-list'),
    path('orders/', OrderCreateView.as_view(), name='order-create'),
    path('orders/<int:pk>/', OrderRetrieveUpdateDestroyView.as_view(), name='order-detail'),
]
