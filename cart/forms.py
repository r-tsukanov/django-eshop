from django import forms
from shop.models import Size, Color


# ограничиваем выбор кол-ва единиц товара до 20
PRODUCT_QUANTITY_CHOICES = [(i, str(i)) for i in range(1, 21)]

class CartAddProductForm(forms.Form):
    # Добавляем поля для выбора размера и цвета
    size = forms.ModelChoiceField(queryset=Size.objects.all(), empty_label=None)
    color = forms.ModelChoiceField(queryset=Color.objects.all(), empty_label=None)
    quantity = forms.TypedChoiceField(choices=PRODUCT_QUANTITY_CHOICES, coerce=int)

    # override = forms.BooleanField(required=False, initial=False, widget=forms.HiddenInput)

class CartEditProductForm(forms.Form):
    # выбор кол-ва товара от 1 до 20
    quantity = forms.TypedChoiceField(choices=PRODUCT_QUANTITY_CHOICES, coerce=int)
