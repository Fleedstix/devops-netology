# Домашнее задание к занятию "6.4. PostgreSQL"

> 1. Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
Подключитесь к БД PostgreSQL используя psql.
Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.

> вывода списка БД

```
postgres=# \list
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```

> подключения к БД

```
postgres=# \connect template1
You are now connected to database "template1" as user "postgres".
```

> вывода списка таблиц
```
template1=# \dt
```

> вывода описания содержимого таблиц
```
template1=# \d+
                              List of relations
 Schema |  Name   | Type  |  Owner   | Persistence |    Size    | Description
--------+---------+-------+----------+-------------+------------+-------------
 public | clients | table | postgres | permanent   | 8192 bytes |
(1 row)
```
> выхода из psql
```
template1=# \q
```
> 2. Используя psql создайте БД test_database.
```
postgres@02160aca960f:/$ createdb -T template0 test_database
```
>Изучите бэкап БД.
Восстановите бэкап БД в test_database.

```
postgres@02160aca960f:~$ psql test_database < dump
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```
>Перейдите в управляющую консоль psql внутри контейнера.
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```
test_database=# ANALYZE VERBOSE orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
```

> Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.
```
test_database=# SELECT attname, avg_width FROM pg_stats WHERE (tablename, attname) IN ( VALUES ('orders', 'id'), ('orders','title'), ('orders','price'));
 attname | avg_width
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)
```
> Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.

> 3. Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).
Предложите SQL-транзакцию для проведения данной операции.
```
create table orders_1 ( CHECK (price >= 500)) inherits (orders);
create table orders_2 ( CHECK (price <= 499)) inherits (orders);
create table orders_temp as select * from orders;
create rule orders_insert_to_1 as on insert to orders where (price >= 500) do instead insert into orders_1 values (NEW.*);
create rule orders_insert_to_2 as on insert to orders where (price <= 499) do instead insert into orders_2 values (NEW.*);
TRUNCATE table orders;
INSERT INTO orders (select * from orders_temp);
DROP orders_temp;
```
> Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

До можно было бы, создав правило приведенное выше, СУБД самостоятельно разбивает данные по таблицам

> 4. Используя утилиту pg_dump создайте бекап БД test_database.
```
pg_dump test_database > backup.sql
```
> Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?
```
CREATE INDEX orders_ttl_idx ON ONLY orders (title);
ALTER TABLE ONLY orders ADD UNIQUE (title);
ALTER TABLE orders_1 ADD UNIQUE (title);
ALTER TABLE orders_2 ADD UNIQUE (title);
```