
def generate_breadcrumbs(current_path, title):
    breadcrumbs = [
        {'url': '/', 'name': 'Главная'},
        {'url': current_path, 'name': title},
    ]
    return breadcrumbs


def menu_bar(all_categories):
    # all_categories = Category.objects.all()
    # 1, 2 это id категорий для горизонтального меню, для которых нужно получить потомков
    category_ids = [1, 2]
    # Фильтрация категорий с нужными id
    selected_category_1 = all_categories.filter(id=category_ids[0]).first()
    selected_category_2 = all_categories.filter(id=category_ids[1]).first()
    # Получение потомков для каждой выбранной категории
    # Метод get_descendants() используется в библиотеке MPTT для получения всех потомков данной категории в дереве.
    descendants_category_1 = selected_category_1.get_descendants() if selected_category_1 else []
    descendants_category_2 = selected_category_2.get_descendants() if selected_category_2 else []

    return {'descendants_category_1': descendants_category_1,
            'descendants_category_2': descendants_category_2}


# пока отложил написание класса сортировки
class SortParams:

    def __init__(self, request, all_products=None, unique_brands=None):
        self.request = request
        self.selected_gender = request.GET.get('gender', None)
        self.all_products = all_products
        self.unique_brands = unique_brands


    def gender_sort(self):

        if self.selected_gender:
            filtered_products = self.all_products.filter(gender=self.selected_gender)

            return filtered_products

        return self.all_products

    def brand_sort(self):
        sort_param = self.request.GET.get('brand_name', 'default')
        if sort_param in self.unique_brands:
            selected_brand = self.request.GET.get('brand_name', None)

            if selected_brand:
                filtered_products = self.all_products.filter(brand_name=selected_brand)

                return filtered_products

