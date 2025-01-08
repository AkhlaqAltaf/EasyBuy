from django.contrib.admin import AdminSite
# Custom Admin Site class
class MyAdminSite(AdminSite):
    site_header = 'EasyBuy With 3D Augmented Reality'
    site_title = 'EasyBuy Admin Dashboard'
    index_title = 'Welcome to EasyBuy Admin Panel'

# Create an instance of the custom admin site
admin_site = MyAdminSite(name='myadmin')

