from django.contrib import admin
from django import forms
from django.db import models
from django.forms import Textarea, SelectMultiple
from .models import Category, Brand, Product, Color, Size, Product_Images
from django.contrib.admin.widgets import FilteredSelectMultiple
from mptt.admin import MPTTModelAdmin


@admin.register(Color)
class AdminColor(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('color_name',)}
    list_display = ['color_name']

@admin.register(Size)
class AdminSize(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('size_name',)}
    list_display = ['size_name']

@admin.register(Brand)
class BrandAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ['name', 'description']
    search_fields = ['name']


@admin.register(Category)
class CategoryAdmin(MPTTModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ['name']
    readonly_fields = ('url_path',)

class ProductImageInlineForm(forms.ModelForm):
    class Meta:
        model = Product_Images
        fields = '__all__'

    # def clean_img_original(self):
    #     img_original = self.cleaned_data['img_original']
    #     if img_original:
    #         raise forms.ValidationError("Вы не можете изменить изображение. Вы можете только удалить его.")
    #     return img_original


class ProductImageInline(admin.TabularInline):
    model = Product_Images
    extra = 1  # Указывает количество пустых форм для загрузки изображений
    fields = ['position', 'img_original']
    form = ProductImageInlineForm  # Используем нашу форму
    ordering = ['-position']

    # def has_change_permission(self, request, obj=None):
    #     # Отключаем возможность изменения (загрузки) изображений
    #     return False


@admin.register(Product)
class AdminProduct(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}
    list_display = ['name', 'brand', 'category']
    autocomplete_fields = ['brand']  # Добавляем выбор бренда из class BrandAdmin
    readonly_fields = ('brand_name',)
    filter_horizontal = ['color', 'size']
    formfield_overrides = {
        models.TextField: {'widget': Textarea(attrs={'rows': 6, 'cols': 60})},
        models.ManyToManyField: {'widget': FilteredSelectMultiple('Categories', False)},
    }

    inlines = [ProductImageInline]  # Вставляем форму загрузки изображений

