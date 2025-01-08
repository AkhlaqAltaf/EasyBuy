from django.contrib import admin
from .models import Order, OrderItem
from ..core.admin import admin_site

# Register your models here.
admin_site.register(Order)
admin_site.register(OrderItem)