from rest_framework import serializers
from src.apps.product.models import Category, SubCategory, Product, ProductVariant, ShippingInfo, Review, Media

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'
class MediaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Media
        fields = ['file', 'media_type','is_primary']  # You can include other fields if needed


class SubCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SubCategory
        fields = '__all__'


class ProductSerializer(serializers.ModelSerializer):
    media = MediaSerializer(many=True, read_only=True)  # Include the media field

    class Meta:
        model = Product
        fields = '__all__'


class ProductVariantSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductVariant
        fields = '__all__'


class ShippingInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingInfo
        fields = '__all__'


class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'


