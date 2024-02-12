
from django.shortcuts import render, redirect
from django.contrib.auth import login
from .models import Profile, Wishlist
from .forms import NewUserForm
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from Eshop.settings import BASE_DIR, MEDIA_ROOT, MEDIA_URL, IMAGES_URL
from .forms import NewUserProfile, EditUserForm
from django.http import JsonResponse
from django.views import View

class WishlistView(View):
    def post(self, request, *args, **kwargs):
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            user_id = request.POST.get("user_id")
            product_id = request.POST.get("product_id")

            existing_wishlist_item = Wishlist.objects.filter(user_id=user_id, product_id=product_id).first()

            if existing_wishlist_item:
                existing_wishlist_item.delete()
                return JsonResponse({"status": "removed"})
            else:
                wishlist = Wishlist(product_id=product_id, user_id=user_id)
                wishlist.save()
                return JsonResponse({"status": "added"})

        return render(request, 'wishlist.html')  # Вернуть ваш шаблон или другую реакцию на не-AJAX запрос

    def get(self, request, *args, **kwargs):
        user_id = request.user.id  # Получите id пользователя, который просматривает избранное
        wishlist_items = Wishlist.objects.filter(user_id=user_id)

        context = {
            'wishlist_items': wishlist_items,
        }

        return render(request, 'users/wishlist.html', context)



# class WishlistView(View):
#     template_name = 'shop/wishlist.html'
#
    # def get(self, request, *args, **kwargs):
    #     user_id = request.user.id  # Получите id пользователя, который просматривает избранное
    #     wishlist_items = Wishlist.objects.filter(user_id=user_id)
    #
    #     context = {
    #         'wishlist_items': wishlist_items,
    #     }
    #
    #     return render(request, self.template_name, context)




def register(request):

    if request.method == 'POST':
        form = NewUserForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('shop:index')

    form = NewUserForm()
    context = {'form': form}

    return render(request, 'users/register.html', context)


@login_required
def profile(request):
    user = request.user

    try:
        profile = user.profile
    except Profile.DoesNotExist:
        profile = None

    if request.method == "POST":

        user_form = EditUserForm(request.POST, instance=user)
        profile_form = NewUserProfile(request.POST, request.FILES, instance=profile)

        if user_form.is_valid() and profile_form.is_valid():
            user_form.save()

            profile = profile_form.save(commit=False)
            profile.user = user
            profile.save()
    else:
        user_form = EditUserForm(instance=user)
        profile_form = NewUserProfile(instance=profile)

    context = {'profile_form': profile_form, 'user_form': user_form}
    return render(request, "users/profile.html", context)




# @login_required
# def profile(request):
#
#     if request.method == "POST":
#         user = request.user
#         first_name = request.POST.get("first_name")
#         last_name = request.POST.get("last_name")
#         contact_number = request.POST.get("contact_number")
#         city = request.POST.get("city")
#         address = request.POST.get("address")
#         image = request.FILES["image"]
#
#         profile = Profile(user=user,
#                           first_name=first_name,
#                           last_name=last_name,
#                           contact_number=contact_number,
#                           city=city,
#                           address=address,
#                           image=image)
#         profile.save()
#
#     form = NewUserProfile()
#     context = {'form': form}
#     return render(request, "users/profile.html", context)


