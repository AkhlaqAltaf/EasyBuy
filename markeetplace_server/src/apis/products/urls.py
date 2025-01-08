from rest_framework import routers
from django.urls import path, include
from src.apis.products.views import CategoryViewSet, SubCategoryViewSet, ProductViewSet, ProductVariantViewSet, ShippingInfoViewSet, ReviewViewSet, MediaViewSet
app_name='products'

# Create a router and register all viewsets
router = routers.DefaultRouter()
router.register(r'categories', CategoryViewSet)
router.register(r'subcategories', SubCategoryViewSet)
router.register(r'products', ProductViewSet)
router.register(r'productvariants', ProductVariantViewSet)
router.register(r'shippinginfo', ShippingInfoViewSet)
router.register(r'reviews', ReviewViewSet)
router.register(r'media', MediaViewSet)
urlpatterns = [
    path('', include(router.urls)),  # Register all viewsets
]