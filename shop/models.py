import os
import hashlib
from django.db import models
from mptt.models import MPTTModel, TreeForeignKey
from PIL import Image
from Eshop.settings import BASE_DIR
# from shop.utils import url_path_rewrite

images_dir = 'images'


def url_path_rewrite():
    all_categories = Category.objects.all()

    for cat in all_categories:
        new_url_path = cat.get_full_slug_path()
        old_url_path = cat.url_path

        if new_url_path != old_url_path:
            cat.url_path = new_url_path
            cat.save()

    return None


def image_original_name(img, filename):
    # Создаем хеш MD5 из содержимого файла, чтобы получить уникальное имя
    extension = filename.rsplit('.', 1)[1].lower()  # Получаем расширение
    md5 = hashlib.md5(filename.encode()).hexdigest()

    return f'{images_dir}/{md5}.{extension}'


def image_big_name(id, filename):
    extension = filename.rsplit('.', 1)[1].lower()  # Получаем расширение
    return f'{id}_big.{extension}'

def image_small_name(id, filename):
    extension = filename.rsplit('.', 1)[1].lower()
    return f'{id}_small.{extension}'

def image_thumb_name(id, filename):
    extension = filename.rsplit('.', 1)[1].lower()
    return f'{id}_thumb.{extension}'


class Color(models.Model):
    color_name = models.CharField(max_length=100)
    slug = models.SlugField(max_length=100, unique=True)

    def __str__(self):
        return self.color_name


class Size(models.Model):
    size_name = models.CharField(max_length=100)
    slug = models.SlugField(max_length=100, unique=True)

    def __str__(self):
        return self.size_name


class Category(MPTTModel):
    name = models.CharField(max_length=200)
    # при следующем обновлении не забыть поменять на unique=True
    slug = models.SlugField(max_length=200, unique=False)
    parent = TreeForeignKey('self', null=True, blank=True, related_name='children', on_delete=models.CASCADE)
    url_path = models.TextField(blank=True)

    def save(self, *args, **kwargs):
        super(Category, self).save(*args, **kwargs)

        url_path_rewrite()

    class MPTTMeta:
        order_insertion_by = ['name']

    def __str__(self):
        return self.name

    # эта рекурсия вызывается, только при обновлении категорий в админке
    def get_full_slug_path(self):
        # Рекурсивная функция для получения полного пути slug'ов
        def get_slug_path_recursive(category):
            if category.parent:
                return f"{get_slug_path_recursive(category.parent)}/{category.slug}"
            return category.slug

        return get_slug_path_recursive(self)


class Brand(models.Model):
    name = models.CharField(max_length=255)
    slug = models.SlugField(max_length=255, unique=True)
    description = models.TextField(blank=True)

    def __str__(self):
        return self.name


class Product(models.Model):
    name = models.CharField(max_length=200)
    slug = models.SlugField(max_length=200, unique=False)
    category = models.ForeignKey(Category, null=True, on_delete=models.DO_NOTHING, related_name='category')
    brand = models.ForeignKey(Brand, null=True, on_delete=models.DO_NOTHING, related_name='brand')
    # brand_name сюда будет прописываться или перезаписываться имя выбраного бренда товара из таблицы Brand,
    # чтобы лишний раз не делать запрос за названием бренда
    brand_name = models.CharField(max_length=250, blank=True)

    def save(self, *args, **kwargs):
        self.brand_name = self.brand.name
        super(Product, self).save(*args, **kwargs)

    description = models.TextField(blank=True)
    additional_description = models.TextField(blank=True)

    men = 'men'
    woman = 'woman'
    uni = 'uni'

    GENDERS = [
        (men, 'мужской'),
        (woman, 'женский'),
        (uni, 'унисекс'),
    ]

    gender = models.CharField(max_length=6, choices=GENDERS, default=uni)
    composition = models.CharField(max_length=100, blank=True)
    color = models.ManyToManyField(Color)
    size = models.ManyToManyField(Size)
    price = models.DecimalField(max_digits=10, decimal_places=0, null=False, default=0)

    def __str__(self):
        return f'{self.name} {self.brand.name}'


class Product_Images(models.Model):
    position = models.IntegerField(default=0)
    img_original = models.ImageField(upload_to=image_original_name, blank=True)
    img_big = models.CharField(max_length=255, default='')
    img_small = models.CharField(max_length=255, default='')
    img_thumb = models.CharField(max_length=255, default='')
    product = models.ForeignKey(Product, null=False, on_delete=models.DO_NOTHING, related_name='images', default=0)

    @staticmethod
    def pre_create(product_id, img_original):
        # сохраняем в БД оригинал изображения (md5 хеш имени этой фотографии + расширение)
        # и id продукта в поле foreign_key
        Product_Images.objects.create(product_id=product_id, img_original=img_original)

    # def save() это обработчик события сохранения экземпляра класса в БД
    # здесь по сути переписывание стандартной функции save для любой модели
    def save(self, *args, **kwargs):

        super(Product_Images, self).save(*args, **kwargs)

        # ниже идет дополнение функции save
        if self.img_big == '' and self.img_thumb == '':
            max_position = Product_Images.objects.filter(product=self.product).aggregate(models.Max('position'))[
                'position__max']

            # Увеличьте 'position' на 1 относительно максимального значения или установите 0, если нет предыдущих изображений
            if max_position is None or max_position == 0:
                self.position = 1
            else:
                self.position = max_position + 1

            # print(max_position)
            save_path = os.path.join(BASE_DIR, 'media', images_dir, )

            # после выполнения сохранения получаем доступ к данным таблицы: self.id, self.img_original

            img_original_name = self.img_original.name.replace(images_dir + '/', '')

            # Устанавливаем размер для большого изображения (можно изменить размер по вашему усмотрению)
            img = Image.open(os.path.join(save_path, img_original_name))
            img.thumbnail((1000, 1000), Image.LANCZOS)
            big_filename = image_big_name(self.id, img_original_name)
            img.save(os.path.join(save_path, big_filename))

            img = Image.open(os.path.join(save_path, img_original_name))
            img.thumbnail((250, 250), Image.LANCZOS)
            small_filename = image_small_name(self.id, img_original_name)
            img.save(os.path.join(save_path, small_filename))

            img = Image.open(os.path.join(save_path, img_original_name))
            img.thumbnail((100, 100))
            thumb_filename = image_thumb_name(self.id, img_original_name)
            img.save(os.path.join(save_path, thumb_filename))

            # Получаем объект Product_Images, который нужно обновить (например, по его ID)
            postsave_image = Product_Images.objects.get(id=self.id)

            # Выполняем обновление полей img_big, img_small, img_thumb
            postsave_image.img_big = big_filename
            postsave_image.img_small = small_filename
            postsave_image.img_thumb = thumb_filename

            # Сохраняем изменения
            postsave_image.save()

    def delete(self, *args, **kwargs):
        save_path = os.path.join(BASE_DIR, 'media', images_dir, )
        save_path_original = os.path.join(BASE_DIR, 'media/')
        img_original_path = os.path.join(save_path_original, self.img_original.name)
        img_big_path = os.path.join(save_path, self.img_big)
        img_small_path = os.path.join(save_path, self.img_small)
        img_thumb_path = os.path.join(save_path, self.img_thumb)

        if self.img_original and os.path.exists(img_original_path):
            os.remove(img_original_path)

        if self.img_big and os.path.exists(img_big_path):
            os.remove(img_big_path)

        if self.img_small and os.path.exists(img_small_path):
            os.remove(img_small_path)

        if self.img_thumb and os.path.exists(img_thumb_path):
            os.remove(img_thumb_path)

        super(Product_Images, self).delete(*args, **kwargs)

# class Meta:
#     ordering = ['name']
# indexes = [models.Index(fields=['name']),]  # делаем индекс на поле name, если понадобится
# поиск по имени категории
# verbose_name = 'category'
# verbose_name_plural = 'categories'  # verbose_name для отображения в админке



# def delete(self, *args, **kwargs):
    #
    #     super(Product, self).delete(*args, **kwargs)
    #
    #     self.colors.clear()
    #     self.sizes.clear()