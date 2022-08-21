# Домашнее задание к занятию "12.3 Развертывание кластера на собственных серверах, лекция 1"

> Сначала проекту необходимо определить требуемые ресурсы. Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:
> 
> База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
> 
> Кэш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
> 
> Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий.
> 
> Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.


1-2 Нода:

|Role|RAM|CPU|
|----|---------|-----|
|front| 50  |  0.2 |
|back x2| 1200 | 1 |
|cash| 4096 | 1 |
| Итого: | 5 346 | 3.2|


3 нода: 
|Role|RAM|CPU|
|----|---------|-----|
|front| 50  |  0.2 |
|back x2| 1200 | 1 |
|cash| 4096 | 1 |
| Итого: | 5 296 | 3|


4-6 Нода
|Role|RAM|CPU|
|----|---------|-----|
|front| 50  |  0.2 |
|back x2| 1200 | 1 |
|bd| 4096 | 1 |
| Итого: | 5 346 | 3.2|


Control Plane (3 шт):

|Role|RAM|CPU|
|----|---------|-----|
|Control Plane x3| 2048мб  |  2 |


Требуется рессурсов на 6 воркер нод:

* CPU: 4*5 + 4 = 24 ядра

* RAM: 5350 * 6 = 32100 мб


Заложим 20% ресурсов "прозапас" в воркер ноды:

* 29 ядер
* 36 гб ОЗУ


Итого: 
* 35 ядер и 45 ОЗУ

* на каждой из шести воркер ноде по 4 ядра и 6 ОЗУ

* три Control Plane 2 ядра и 2 ОЗУ 
