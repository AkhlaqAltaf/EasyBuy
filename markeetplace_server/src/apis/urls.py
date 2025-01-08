from django.urls import include, path
from .docs import get_swagger_doc_schema_view

app_name = 'api'
urlpatterns = []

schema_view = get_swagger_doc_schema_view()
urlpatterns += [
    path('', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]
urlpatterns += [
    path('accounts/', include('src.apis.accounts.urls', namespace='accounts/')),
    path('products/', include('src.apis.products.urls', namespace='products/')),

]

