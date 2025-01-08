"""
URL configuration for marketplace_server project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path

from marketplace_server import settings
from django.conf.urls.static import static

from src.apps.core.admin import admin_site

urlpatterns = [
    path('admin/', admin_site.urls ),
    path('', include('src.apps.core.urls')),
    path('vendor/', include('src.apps.vendor.urls')),
    path('product/', include('src.apps.product.urls')),
    path('accounts/',include('src.apps.accounts.urls')),
    path('cart/', include('src.apps.cart.urls')),
    path('order/', include('src.apps.order.urls')),
    # path('',include('src.apps.website.urls',namespace='website')),
    path('admin/', admin.site.urls),
    path('api/',include('src.apis.urls',namespace='api')),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
