from . import views
from django.urls import path, include, re_path

app_name = 'shop'

urlpatterns = [

    path('', views.show_index, name='index'),

    re_path(r'^catalog', views.show_categories, name='show_categories'),
    re_path(r'^catalog/(?P<url_path>.+)/$', views.show_categories, name='show_categories'),
    # path('category/<slug:category_slug>/', views.category_detail, name='category_detail'),
    path('product/<int:product_id>/', views.product_detail, name='product_detail'),
    path('brand/<int:brand_id>/', views.show_brand_catalog, name='show_brand_catalog'),
    path('search/', views.product_search, name='product_search'),
    path('contacts/', views.contacts, name='contacts'),

    path("__debug__/", include("debug_toolbar.urls")),
]
