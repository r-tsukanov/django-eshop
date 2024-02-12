from django import template

register = template.Library()


@register.filter(name='pluralize_result')
def pluralize_result(value, arg="результат,результата,результатов"):
    args = arg.split(',')
    # проверяем входит ли в список остаток от деления
    if not args or len(args) != 3:
        return value
    value = int(value)
    if value % 100 in [11, 12, 13, 14]:
        return args[2]
    if value % 10 == 1:
        return args[0]
    if value % 10 in [2, 3, 4]:
        return args[1]
    return args[2]