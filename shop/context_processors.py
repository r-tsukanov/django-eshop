from .models import Category

def menu_bar(request):
    all_categories = Category.objects.all()

    # 1, 2 это id категорий для горизонтального меню, для которых нужно получить потомков
    # эти первые категории верхнего уровня, будет создавать инсталятор
    category_ids = [1, 2]
    selected_category_1 = all_categories.filter(id=category_ids[0]).first()
    selected_category_2 = all_categories.filter(id=category_ids[1]).first()
    # Метод get_descendants() используется в библиотеке MPTT для получения всех потомков данной категории в дереве.
    # В MPTT, каждый узел дерева имеет левый и правый индексы, а получение потомков основано на этих индексах.
    descendants_category_1 = selected_category_1.get_descendants() if selected_category_1 else []
    descendants_category_2 = selected_category_2.get_descendants() if selected_category_2 else []

    return {'descendants_category_1': descendants_category_1,
            'descendants_category_2': descendants_category_2}


def title(request):
    # Код для определения заголовка страницы, чтобы потом извлекать и использовать в описанни breadcrumbs
    # Извлекаем, переменную title из контекста, если она есть или возвращаем дефолтный заголовок
    return {'title': request.GET.get('title') or 'Django E-shop заголовок по умолчанию'}


