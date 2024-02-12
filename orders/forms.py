from django import forms
from .models import Order
from users.models import Profile
from django.contrib.auth.models import User

class OrderCreateForm(forms.ModelForm):
    class Meta:
        model = Order
        fields = ['first_name', 'last_name', 'contact_number', 'address', 'city']

