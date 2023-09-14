my_cache
=====

An OTP library

Build
-----

    $ rebar3 compile


## Порівняння Dict, maps, proplist, ets
module із замірами часу: ```src/compare.erl```
```
Dict:
4
0
0

proplist:
0
0
0

maps:
Get Value time:
0
0
0

ets:
insert value time
3
0
0
get value time
1
0
0

Process Dictionary
insert value:
2
0
0
get value:
0
erase values:
0
```

Порівнюючи ці значення, бачимо, що maps иа proplist використовують менше за всіх часу 
для отримання значення. У proplist таке досягається через статичну кількість
елементів всередині.

У ets бувають великі "скачки" часу для вствлення запису. При інших запусках
значення бували і 14-20.


# Process Dictionary:

Прив'язаний до процесу: Кожен процес в Erlang має свій власний словник. Інформація в словнику доступна тільки в межах даного процесу і не видно іншим процесам.

Динамічність: Словник процесу може бути динамічно змінений під час виконання процесу.

Локальність: Він є локальним для кожного процесу і не може бути використаний для обміну даними між процесами.

# Maps:

Загальний доступ: Maps надають загальний доступ до всіх процесів у системі. Їх можна використовувати для обміну даними між процесами.

Незмінність: Maps є незмінними структурами даних, що означає, що після створення карти ви не можете змінити її вміст. Замість цього створюється нова змынна, яка містить maps з оновленими даними.

Ефективність: Вони надають швидкий доступ до даних і можуть використовуватися для пошуку значень за ключем.

# Proplist:

Список пар ключ-значення: 
Proplist - це список пар, де кожна пара представляє собою ключ і відповідне значення. 
Прохід по proplist може бути неефективним для великих списків.

Послідовний доступ: Зазвичай елементи proplist доступні послідовно, і пошук елемента за ключем може вимагати проходження всіх попередніх елементів.

Простота: Proplist простий у використанні, але може бути неефективним для великих обсягів даних.

# ETS (Erlang Term Storage):

Глобальний доступ: Таблиці ETS надають загальний доступ до даних між процесами і можуть використовуватися для обміну даними між процесами.

Ефективність: Вони надають високу продуктивність для операцій читання та запису даних і можуть використовуватися для зберігання великих обсягів даних.

Багато опцій: Таблиці ETS мають різні опції, що дозволяють налаштовувати типи блокування, типи таблиць та інші характеристики зберігання даних.