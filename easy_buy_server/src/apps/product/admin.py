from django.contrib import  admin
from .models import (Product,ProductImage,Review,Order,OrderItem,Category)
@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name',)
    list_filter = ('name','created_at')
    search_fields = ('name','created_at')


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('category','name','price','stock')
    list_filter = ('category','name','price','stock')
    search_fields = ('category','name','price','stock')

@admin.register(ProductImage)
class ProductImageAdmin(admin.ModelAdmin):
    list_display = ('product','image')
    list_filter = ('product','image')
    search_fields = ('product','image')


@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    list_display = ('product','user','rating','title',)
    list_filter = ('product','user','rating','title',)
    search_fields = ('product','user','rating','title',)


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('user','created_at','is_paid','is_shipped')
    list_filter = ('user','created_at')
    search_fields = ('user','created_at')



@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('order','product','quantity','price')
    list_filter =  ('order','product','quantity','price')
    search_fields =  ('order','product','quantity','price')


