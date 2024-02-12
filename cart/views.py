from django.shortcuts import render, redirect, get_object_or_404
from django.views.decorators.http import require_POST
from shop.models import Product, Product_Images
from .cart import Cart
from .forms import CartAddProductForm, CartEditProductForm
from shop.utils import generate_breadcrumbs

@require_POST
def cart_add(request, product_id):
    cart = Cart(request)
    # print('hello')
    product = get_object_or_404(Product, id=product_id)
    images = Product_Images.objects.filter(product_id=product.id)

    form = CartAddProductForm(request.POST)

    # print(form.__dict__)
    # print(form.is_valid())
    if form.is_valid():
        cd = form.cleaned_data
        # Получите данные о размере и цвете
        size = form.cleaned_data['size']
        color = form.cleaned_data['color']
        # print(f"quantity= {cd['quantity']}, override_quantity= {cd['override']}")
        cart.add(product=product, size=size, color=color,
                 images=images, quantity=cd['quantity'])

    return redirect('cart:cart_detail')


@require_POST
def cart_edit(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)

    form = CartEditProductForm(request.POST)

    # print(form.__dict__)
    # print(form.is_valid())
    if form.is_valid():
        cd = form.cleaned_data
        print(f"quantity= {cd['quantity']}")
        cart.edit(product=product, quantity=cd['quantity'])

    return redirect('cart:cart_detail')


@require_POST
def cart_remove(request, product_id):
    cart = Cart(request)
    product = get_object_or_404(Product, id=product_id)
    cart.remove(product)

    # redirect чтобы заново не отправлять POST данные, если снова обновить страницу
    return redirect('cart:cart_detail')


def cart_detail(request):
    cart = Cart(request)

    for item in cart:
        item['update_quantity_form'] = CartAddProductForm(initial={'quantity': item['quantity'],
                                                                   'override': True})

    title = 'Корзина'
    # Получение текущего пути
    current_path = request.path_info
    # Генерация breadcrumbs
    breadcrumbs = generate_breadcrumbs(current_path, title)

    return render(request, 'cart/detail.html', {'cart': cart,
                                                'breadcrumbs': breadcrumbs,
                                                'title': title})