from django.shortcuts import render, get_object_or_404
from django.db.models import Prefetch
from .models import Category, Brand, Product, Color, Size, Product_Images
from Eshop.settings import BASE_DIR, MEDIA_ROOT, IMAGES_URL
from cart.forms import CartAddProductForm
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .utils import generate_breadcrumbs
from shop.forms import SearchForm
from django.db.models import Q

def get_category_and_parents(slug):
    # Метод get_family() используется в библиотеке MPTT
    category = get_object_or_404(Category, slug=slug)
    # parents_category = [{'id': '/', 'name': 'Главная'}] + list(category.get_family().values('id', 'name', 'slug'))
    parents_category = category.get_family().values_list('slug', flat=True)
    return parents_category

def get_category_and_descendants(slug):
    # Метод get_descendants() используется в библиотеке MPTT для получения всех потомков данной категории в дереве.
    # В MPTT, каждый узел дерева имеет левый и правый индексы, а получение потомков основано на этих индексах.
    category = get_object_or_404(Category, slug=slug)
    descendants_ids = [category.id] + list(category.get_descendants().values_list('id', flat=True))
    return category, descendants_ids


def show_categories(request):
    # Получение текущего пути
    current_path = request.path_info
    # Проверка, заканчивается ли путь слэшем, и добавление его, если необходимо
    if current_path[-1] != '/':
        current_path += '/'
    # Разделение пути на список компонентов
    path_info = current_path.split('/')
    # print(path_info)
    # Получение текущей категории и ее потомков на основе последнего компонента пути
    category, descendants_ids = get_category_and_descendants(path_info[-2])
    # print(descendants_ids)

    # Создание списка слагов из непустых компонентов пути
    slug_list = [x for x in path_info if x]
    breadcrumbs = []
    for slug in slug_list:
        # Для каждого слага в списке строится запрос категории по слагу, и результат добавляется в "хлебные крошки"
        breadcrumbs.append(Category.objects.filter(slug=slug))

    print(breadcrumbs)
    # Получение всех продуктов, относящихся к текущей категории и ее потомкам
    all_products = Product.objects.filter(category_id__in=descendants_ids).prefetch_related('images')

    # Применение сортировки
    # Получаем уникальные бренды для использования в выпадающем списке
    unique_brands = Product.objects.values_list('brand_name', flat=True).distinct()
    filtered_products = all_products  # Инициализация переменной перед использованием

    sort_param = request.GET.get('brand_name', 'default')

    if sort_param in unique_brands:
        selected_brand = request.GET.get('brand_name', None)

        if selected_brand:
            filtered_products = all_products.filter(brand_name=selected_brand)

    selected_gender = request.GET.get('gender', None)
    if selected_gender:
        filtered_products = all_products.filter(gender=selected_gender)

    sort_param = request.GET.get('sort', 'default')

    if sort_param == 'price_max':
        filtered_products = all_products.order_by('-price')
    elif sort_param == 'price_min':
        filtered_products = all_products.order_by('price')
    else:
        pass
    # Обработка значения 'default'

    # Применение пагинации
    paginator = Paginator(filtered_products, 6)  # Показываем кол-во товара на странице
    page = request.GET.get('page')

    try:
        filtered_products = paginator.page(page)
    except PageNotAnInteger:
        # Если page не является целым числом, отображаем первую страницу
        filtered_products = paginator.page(1)
    except EmptyPage:
        # Если страница выходит за пределы доступных страниц, отображаем последнюю страницу
        filtered_products = paginator.page(paginator.num_pages)

    last_value = [tree_queryset.last() for tree_queryset in breadcrumbs if tree_queryset.exists()]
    # print(last_value[-1])
    title = last_value[-1]

    return render(request, 'shop/category_detail.html', {'category': category,
                                                         'products': filtered_products,
                                                         'unique_brands': unique_brands,
                                                         'sort_param': sort_param,
                                                         'breadcrumbs': breadcrumbs,
                                                         'IMAGES_URL': IMAGES_URL,
                                                         'title': title
                                                         })


def show_index(request):
    categories = Category.objects.all()  # Получите все категории из базы данных
    all_products = Product.objects.all().prefetch_related('images')

    # Применение сортировки
    # Получаем уникальные бренды для использования в выпадающем списке
    unique_brands = Product.objects.values_list('brand_name', flat=True).distinct()
    filtered_products = all_products  # Инициализация переменной перед использованием

    # sort_params_instance = SortParams(request, all_products, unique_brands)
    #
    # filtered_products = sort_params_instance.gender_sort()
    # filtered_products = sort_params_instance.brand_sort()

    range_min_price = request.GET.get('min_price')
    range_max_price = request.GET.get('max_price')
    # print(type(range_min_price))
    # print(range_min_price)

    if range_min_price is not None and range_max_price is not None:
        range_min_price = int(range_min_price)
        range_max_price = int(range_max_price)
        # были ли изменения дефолтных значений из формы слайдера
        if range_min_price != 0 or range_max_price != 9000:
            filtered_products = Product.objects.filter(price__range=(range_min_price, range_max_price))

    # сортировка по брэнду
    sort_param = request.GET.get('brand_name', 'default')
    if sort_param in unique_brands:
        selected_brand = request.GET.get('brand_name', None)

        if selected_brand:
            filtered_products = all_products.filter(brand_name=selected_brand)

    # сортировка по гендеру
    selected_gender = request.GET.get('gender', None)
    if selected_gender:
        filtered_products = all_products.filter(gender=selected_gender)

    # сортировка по цене мин и макс
    sort_param = request.GET.get('sort', 'default')
    if sort_param == 'price_max':
        filtered_products = all_products.order_by('-price')
    elif sort_param == 'price_min':
        filtered_products = all_products.order_by('price')
    else:
        pass
    # Обработка значения 'default'

    # Применение пагинации
    paginator = Paginator(filtered_products, 6)  # Показываем кол-во товара на странице
    page = request.GET.get('page')

    try:
        filtered_products = paginator.page(page)
    except PageNotAnInteger:
        # Если page не является целым числом, отображаем первую страницу
        filtered_products = paginator.page(1)
    except EmptyPage:
        # Если страница выходит за пределы доступных страниц, отображаем последнюю страницу
        filtered_products = paginator.page(paginator.num_pages)

    return render(request, 'shop/index.html', {'categories': categories,
                                               # 'menu_data': menu_data,
                                               'products': filtered_products,
                                               'unique_brands': unique_brands,
                                               'sort_param': sort_param,
                                               'IMAGES_URL': IMAGES_URL})


def show_brand_catalog(request, brand_id):
    products = Product.objects.filter(brand_id=brand_id).prefetch_related('images')

    # запрос возвращает результат метода __str__
    brand = get_object_or_404(Brand, id=brand_id)
    # передача строки <title> в base.html через shop.context_processors.title
    title = f'Каталог бренда {brand}'
    # Получение текущего пути
    current_path = request.path_info
    # Генерация breadcrumbs
    breadcrumbs = generate_breadcrumbs(current_path, title)

    return render(request, 'shop/brand_catalog.html', {'products': products,
                                                       'IMAGES_URL': IMAGES_URL,
                                                       'breadcrumbs': breadcrumbs,
                                                       'title': title})


def product_detail(request, product_id):
    # Используем prefetch_related для получения связанных данных
    # to_attr - это аргумент, который используется в Prefetch для указания имени атрибута,
    # в который будут сохранены связанные объекты.
    # product_colors и product_sizes это произвольные имена для этих атрибутов.
    product = Product.objects.filter(id=product_id).prefetch_related(
        Prefetch('color', queryset=Color.objects.all(), to_attr='product_colors'),
        Prefetch('size', queryset=Size.objects.all(), to_attr='product_sizes'),
    ).first()

    # print(product.category_id)
    category_request = get_object_or_404(Category, id=product.category_id)
    # Получение текущей категории и ее потомков на основе последнего компонента пути
    parents_category = get_category_and_parents(category_request.slug)

    # print(parents_category)

    # Создание списка слагов из непустых компонентов пути
    slug_list = [x for x in parents_category if x]
    breadcrumbs = []
    for slug in slug_list:
        # Для каждого слага в списке строится запрос категории по слагу, и результат добавляется в "хлебные крошки"
        breadcrumbs.append(Category.objects.filter(slug=slug))

    print(breadcrumbs)

    # запрос возвращает результат метода __str__
    brand = get_object_or_404(Brand, id=product.brand_id)
    images = Product_Images.objects.filter(product=product)

    cart_product_form = CartAddProductForm()
    # Передаем данные в форму
    cart_product_form.fields['size'].queryset = product.size.all()
    cart_product_form.fields['color'].queryset = product.color.all()
    # передача строки <title> в base.html через shop.context_processors.title
    title = f'{product.name} {product.brand_name}'


    return render(request, 'shop/product_detail.html', {'product': product,
                                                        'brand': brand,
                                                        'images': images,
                                                        'IMAGES_URL': IMAGES_URL,
                                                        'cart_product_form': cart_product_form,
                                                        'breadcrumbs': breadcrumbs,
                                                        'title': title})


def product_search(request):
    form = SearchForm()
    search_query = None
    results = []

    if 'search_query' in request.GET:
        form = SearchForm(request.GET)
        if form.is_valid():
            search_query = form.cleaned_data['search_query']
            # Разделяем строку запроса на отдельные слова
            words = search_query.split()
            # Создаем Q-объекты для каждого слова и объединяем их в цепочку "OR"
            queries = [Q(name__icontains=word) | Q(brand_name__icontains=word) for word in words]
            query = queries.pop()

            for item in queries:
                query |= item

            # Выполняем поиск с использованием построенного Q-объекта
            results = Product.objects.filter(query)

    # передача строки <title> в base.html через shop.context_processors.title
    title = f'Поиск: {search_query}'

    return render(request, 'shop/search.html', {'form': form,
                                                'search_query': search_query,
                                                'results': results,
                                                'title': title})


def contacts(request):
    # передача строки <title> в base.html через shop.context_processors.title
    title = 'О магазине'
    # Получение текущего пути
    current_path = request.path_info
    # Генерация breadcrumbs
    breadcrumbs = generate_breadcrumbs(current_path, title)

    return render(request, 'shop/contacts.html', {'breadcrumbs': breadcrumbs, 'title': title})





# def add_wishlist(request):
#     if request.method == "POST":
#         user_id = request.POST.get("user_id")
#         product_id = request.POST.get("product_id")
#
#         # Проверяем, существует ли уже запись в Wishlist
#         existing_wishlist_item = Wishlist.objects.filter(user_id=user_id, product_id=product_id).first()
#
#         if existing_wishlist_item:
#             # Если запись существует, удаляем ее
#             existing_wishlist_item.delete()
#             return JsonResponse({"status": "removed"})
#         else:
#             # Если записи нет, добавляем новую
#             wishlist = Wishlist(product_id=product_id, user_id=user_id)
#             wishlist.save()
#             return JsonResponse({"status": "added"})
#
#     return JsonResponse({"status": "error"})

