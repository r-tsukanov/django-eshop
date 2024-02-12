from django.db import models
from shop.models import Product
from users.models import Profile
from django.contrib.auth.models import User


class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    profile = models.ForeignKey(Profile, on_delete=models.CASCADE, null=True, blank=True)

    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    contact_number = models.CharField(max_length=12)
    email = models.EmailField()
    address = models.CharField(max_length=250)
    city = models.CharField(max_length=100)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    paid = models.BooleanField(default=False)

    def save(self, *args, **kwargs):
        # Заполняем поле email из связанного пользователя
        self.email = self.user.email

        # Если профиль пользователя ранее был заполнен
        if self.profile:
            try:
                # Попытка получить связанный профиль. Джанго подставляет _id, user можно здесь писать и без _id
                profile = Profile.objects.get(user_id=self.user.id)
                # Заполняем поля из связанных моделей при сохранении заказа
                self.first_name = profile.first_name
                self.last_name = profile.last_name
                self.contact_number = profile.contact_number
                self.address = profile.address
            except Profile.DoesNotExist:
                # Обработка случая, когда профиль не существует
                pass
        super().save(*args, **kwargs)

    class Meta:
        ordering = ['-created']

    indexes = [
        models.Index(fields=['-created']),
    ]

    def __str__(self):
        return f'Заказ {self.id}'

    def get_total_cost(self):
        return sum(item.get_cost() for item in self.items.all())


class OrderItem(models.Model):
    order = models.ForeignKey(Order, related_name='items', on_delete=models.CASCADE)
    product = models.ForeignKey(Product, related_name='order_items', on_delete=models.CASCADE)
    color = models.CharField(max_length=100)
    size = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField(default=1)

    def __str__(self):
        return str(self.id)

    def get_cost(self):
        return self.price * self.quantity