from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from .models import Order, OrderItem
from users.models import Profile
from .forms import OrderCreateForm
from users.forms import NewUserProfile
from django.contrib.auth.models import User
from cart.cart import Cart

@login_required
def order_create(request):
    # получаем экземпляр пользователя User по его id
    # user = User.objects.get(id=request.user.id)

    user = request.user
    profile = None

    try:
        profile = user.profile
    except Profile.DoesNotExist:
        profile = None

    cart = Cart(request)

    if request.method == 'POST':
        # Получаем данные из форм
        order_form = OrderCreateForm(request.POST)

        if order_form.is_valid():
            order = order_form.save(commit=False)
            order.user = user
            print(order.user)
            # Проверяем, существует ли профиль перед присвоением
            if profile:
                order.profile_id = profile.id
                order.email = user.email
                # order.profile = profile

            order.save()

            for item in cart:
                OrderItem.objects.create(order=order,
                                         product=item['product'],
                                         size=item['size'],
                                         color=item['color'],
                                         price=item['price'],
                                         quantity=item['quantity'])
            # очистить корзину
            cart.clear()
            return render(request,
                          'orders/order/created.html',
                          {'order': order})
    else:
        order_form = OrderCreateForm(instance=profile)

    return render(request, 'orders/order/create.html', {'cart': cart,
                                                        'order_form': order_form,
                                                        })


# if order_form.is_valid() and order_form_addition.is_valid():
#             order = order_form.save(commit=False)
#             order.user = user
#             order.profile = profile
#
#             # Заполнения полей Order из order_form_addition
#             order.id = order_form_addition.cleaned_data['id']
#             order.save()


@login_required
def my_orders_list(request):
    user = request.user
    orders = Order.objects.filter(user_id=user.id).prefetch_related('items')

    return render(request, 'orders/list.html', {'orders': orders})

