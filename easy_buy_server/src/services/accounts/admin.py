from django.contrib import  admin

from src.services.accounts.models import CustomUser


@admin.register(CustomUser)
class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('email','date_joined')
    list_filter = ('email','date_joined')
    search_fields = ('email','date_joined')
    ordering = ('-date_joined',)