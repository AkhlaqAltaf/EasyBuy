import os

from src.apps.accounts.models import CustomUser
from src.apps.vendor.models import Vendor
from django.db import models
from PIL import Image
from io import BytesIO
from django.core.files import File
from ckeditor.fields import RichTextField


# PRODUCT PARENT CATEGORY


class Category(models.Model):
    image = models.ImageField(upload_to='categories/', blank=True, null=True)
    name = models.CharField(max_length=50)
    ordering = models.IntegerField(default=0)

    class Meta:
        ordering = ['ordering']

    def __str__(self):
        return self.name


# PRODUCT SUB CATEGORY


class SubCategory(models.Model):
    image = models.ImageField(upload_to='sub_categories/', blank=True, null=True)
    name = models.CharField(max_length=255, unique=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, related_name="subcategories")

    def __str__(self):
        return f"{self.category.name} - {self.name}"



# PRODUCT COUNTRY ORIGIN

class CountryOrigin(models.Model):
    name = models.CharField(max_length=255, unique=True)
    def __str__(self):
        return self.name



# PRODUCT MODEL


class Product(models.Model):
    STATUS_CHOICES = [
        ('active', 'Active'),
        ('inactive', 'Inactive'),
        ('review', 'Under Review'),
    ]
    name = models.CharField(max_length=255)
    description = models.TextField()
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, related_name='products')
    sub_category = models.ForeignKey(SubCategory, on_delete=models.SET_NULL, null=True, related_name='products')
    tags = models.ManyToManyField('Tag', blank=True)  # Tags are optional
    price = models.DecimalField(max_digits=10, decimal_places=2)
    discount_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stock_quantity = models.PositiveIntegerField(default=0)
    sku = models.CharField(max_length=100, unique=True)
    currency = models.CharField(max_length=10, default='USD')
    vendor = models.ForeignKey(Vendor, on_delete=models.CASCADE, related_name='products')
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='review')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_featured = models.BooleanField(default=False)
    sales_count = models.PositiveIntegerField(default=0)
    country_of_origin = models.ManyToManyField(CountryOrigin, related_name='products')
    content = RichTextField()
    added_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

# Product Tag Model

class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name


# PRODUCT VARIENTS

class ProductVariant(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='variants')
    size = models.CharField(max_length=50, blank=True, null=True)
    color = models.CharField(max_length=50, blank=True, null=True)
    stock_quantity = models.PositiveIntegerField(default=0)

    def __str__(self):
        return f"Variant of {self.product.name}"

# PRODUCT SHIPMENT ADDRESS

class ShippingInfo(models.Model):
    product = models.OneToOneField(Product, on_delete=models.CASCADE, related_name='shipping_info')
    weight = models.DecimalField(max_digits=10, decimal_places=2, help_text='Weight in kilograms')
    dimensions = models.CharField(max_length=100, help_text='Format: Length x Width x Height in cm', blank=True, null=True)
    shipping_class = models.CharField(max_length=50, blank=True, null=True)
    availability = models.TextField(help_text='List of regions or countries', blank=True, null=True)

    def __str__(self):
        return f"Shipping Info for {self.product.name}"


# Product Review Model
class Review(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='reviews')
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    rating = models.PositiveSmallIntegerField(help_text="Rating out of 5")
    comment = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Review for {self.product.name} by {self.user.name}"

# PRODUCT MEDIA

class Media(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="media")
    file = models.FileField(upload_to="products/", default='https://via.placeholder.com/240x180.jpg')
    media_type = models.CharField(max_length=10, editable=False)  # Editable is False to set it programmatically.
    is_primary = models.BooleanField(default=False)

    def make_thumbnail(self, image, size=(300, 200)):
        """
        Generate a thumbnail for the uploaded image.
        """
        img = Image.open(image)
        img = img.convert('RGB')
        img.thumbnail(size)

        thumb_io = BytesIO()
        img.save(thumb_io, 'JPEG', quality=85)

        thumbnail = File(thumb_io, name=image.name)
        return thumbnail

    def save(self, *args, **kwargs):
        """
        Override the save method to handle file type and dynamically set media_type.
        """
        if self.file:
            # Extract the file extension
            ext = os.path.splitext(self.file.name)[1].lower()

            # Check the file type and set media_type accordingly
            if ext in ['.jpg', '.jpeg', '.png']:
                self.media_type = 'image'
                # Generate a thumbnail for images
                self.file = self.make_thumbnail(self.file)
            elif ext in ['.mp4', '.avi', '.mov', '.mkv']:
                self.media_type = 'video'
            elif ext in ['.glb', '.gltf', '.obj', '.fbx']:
                self.media_type = '3d'
            else:
                raise ValueError(f"Unsupported file type: {ext}. Only images, videos, and 3D models are allowed.")

        super().save(*args, **kwargs)  # Call the original save method


class TopPageProduct(models.Model):
    product = models.OneToOneField(Product, on_delete=models.CASCADE, related_name='top_page')
    order = models.PositiveSmallIntegerField(default=0)
    def __str__(self):
        return f"{self.product.name}"


class WishListProduct(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name='wish_list')
    products = models.ManyToManyField(Product, related_name='wish_list', blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.name} Wish List"



class Order(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('shipped', 'Shipped'),
        ('delivered', 'Delivered'),
        ('cancelled', 'Cancelled'),
    ]

    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    products = models.ManyToManyField('Product', through='OrderItem')
    address = models.TextField()
    city = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    postal_code = models.CharField(max_length=20)
    payment_method = models.CharField(max_length=50)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')  # New status field
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Order {self.id} by {self.user.name}"

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    product = models.ForeignKey('Product', on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.quantity} of {self.product.name}"
