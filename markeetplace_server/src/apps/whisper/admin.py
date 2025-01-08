from django.contrib import  admin

from src.apps.core.admin import admin_site
from src.apps.whisper.models import HostInfo

admin_site.register(HostInfo)