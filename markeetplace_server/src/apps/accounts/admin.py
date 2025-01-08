from django.contrib import  admin

from src.apps.accounts.models import CustomUser
from src.apps.core.admin import admin_site
admin_site.register(CustomUser)


