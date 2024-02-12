from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from django import forms
from django.forms import ModelForm
from .models import Profile


# регистрация пользователя
class NewUserForm(UserCreationForm):
    email = forms.EmailField(
        required=True,
        widget=forms.EmailInput(
            attrs={"class": "focus:outline-none", "placeholder": ""}
        ),
    )
    username = forms.CharField(
        required=True,
        widget=forms.TextInput(
            attrs={"class": "focus:outline-none", "placeholder": ""}
        ),
    )
    password1 = forms.CharField(
        required=True,
        widget=forms.PasswordInput(
            attrs={"class": "focus:outline-none", "placeholder": ""}
        ),
    )
    password2 = forms.CharField(
        required=True,
        widget=forms.PasswordInput(
            attrs={"class": "focus:outline-none", "placeholder": ""}
        ),
    )

    class Meta:
        model = User
        fields = ('username', 'email', 'password1', 'password2')


class NewUserProfile(ModelForm):
    first_name = forms.CharField(max_length=50)
    last_name = forms.CharField(max_length=50)
    contact_number = forms.TextInput()
    image = forms.ImageField(required=False)
    city = forms.CharField(max_length=100)
    address = forms.CharField(max_length=250)

    class Meta:
        model = Profile
        fields = ('first_name', 'last_name', 'contact_number', 'city', 'address', 'image', )


class EditUserForm(forms.ModelForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['email']