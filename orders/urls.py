from django.urls import path
from . import views

app_name = 'orders'

urlpatterns = [
    path('create/', views.order_create, name='order_create'),
    path('list/', views.my_orders_list, name='my_orders_list'),
]