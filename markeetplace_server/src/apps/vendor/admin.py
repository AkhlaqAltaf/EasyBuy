from django.contrib import admin
from .models import Vendor

# Register your models here.
# admin.site.register(Vendor)
from django.contrib import admin
from .models import Vendor ,ThreeDModel
from ..core.admin import admin_site

admin_site.register(Vendor)
admin_site.register(ThreeDModel)