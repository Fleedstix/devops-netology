# Домашнее задание к занятию "6.3. MySQL"

>1. Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

[Docker-compose.yml](./1/docker-compose.yml)

> Изучите бэкап БД и восстановитесь из него.

```
mysql -u root -p mydb < dump.sql
```

>Перейдите в управляющую консоль mysql внутри контейнера.
Используя команду \h получите список управляющих команд.
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.
```
mysql> status
--------------
mysql  Ver 8.0.26 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          11
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.26 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 23 min 15 sec

Threads: 2  Questions: 37  Slow queries: 0  Opens: 136  Flush tables: 3  Open tables: 54  Queries per second avg: 0.026
```
> Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```
mysql> use mydb;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLES;
+----------------+
| Tables_in_mydb |
+----------------+
| orders         |
+----------------+
1 row in set (0.00 sec)
```
Приведите в ответе количество записей с price > 300.
В следующих заданиях мы будем продолжать работу с данным контейнером.

```
mysql> select * from orders where price > 300;
+----+----------------+-------+
| id | title          | price |
+----+----------------+-------+
|  2 | My little pony |   500 |
+----+----------------+-------+
1 row in set (0.00 sec)
```

> 2. Создайте пользователя test в БД c паролем test-pass, используя:

> плагин авторизации mysql_native_password

```CREATE USER 'test'@'localhost' IDENTIFIED BY 'test-pass';
ALTER USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass';
```
> срок истечения пароля - 180 дней

```
ALTER USER 'test'@'localhost' PASSWORD EXPIRE INTERVAL 180 DAY;
```

> количество попыток авторизации - 3
```
ALTER USER 'test'@'localhost' FAILED_LOGIN_ATTEMPTS 3;
```
> максимальное количество запросов в час - 100
```
ALTER USER 'test'@'localhost' WITH MAX_QUERIES_PER_HOUR 100;
```
> аттрибуты пользователя:
Фамилия "Pretty"
Имя "James"
```
ALTER USER 'test'@'localhost' ATTRIBUTE '{"fname": "James", "lname": "Pretty"}';
```
> Предоставьте привелегии пользователю test на операции SELECT базы test_db.
```
GRANT SELECT ON test_db.* TO 'test'@'localhost';

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.04 sec)
```

> 3. Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES; 

> Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

Database changed
mysql> show table status;
```
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2021-10-02 17:40:02 | 2021-10-02 17:40:02 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.01 sec)
```
Используется Engine - InnoDB

> Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе: на MyISAM, на InnoD
```
mysql> SHOW PROFILES;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.00011200 | ALTER TABLE orders ENGINE = MyISAM |
|        2 | 0.00023450 | SELECT DATABASE()                  |
|        3 | 0.00463225 | show databases                     |
|        4 | 0.00307525 | show tables                        |
|        5 | 0.08685025 | ALTER TABLE orders ENGINE = MyISAM |
|        6 | 0.07852575 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
6 rows in set, 1 warning (0.00 sec)

mysql> SHOW PROFILE for QUERY 6;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000094 |
| Executing hook on transaction  | 0.000008 |
| starting                       | 0.000027 |
| checking permissions           | 0.000008 |
| checking permissions           | 0.000008 |
| init                           | 0.000017 |
| Opening tables                 | 0.000251 |
| setup                          | 0.000062 |
| creating table                 | 0.000086 |
| After create                   | 0.023599 |
| System lock                    | 0.000024 |
| copy to tmp table              | 0.002151 |
| rename result table            | 0.000978 |
| waiting for handler commit     | 0.000016 |
| waiting for handler commit     | 0.017535 |
| waiting for handler commit     | 0.000024 |
| waiting for handler commit     | 0.016933 |
| waiting for handler commit     | 0.000045 |
| waiting for handler commit     | 0.013227 |
| waiting for handler commit     | 0.000021 |
| waiting for handler commit     | 0.001637 |
| end                            | 0.000460 |
| query end                      | 0.001179 |
| closing tables                 | 0.000012 |
| waiting for handler commit     | 0.000052 |
| freeing items                  | 0.000049 |
| cleaning up                    | 0.000028 |
+--------------------------------+----------+
27 rows in set, 1 warning (0.00 sec)

mysql> SHOW PROFILE for QUERY 5;
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000069 |
| Executing hook on transaction  | 0.000006 |
| starting                       | 0.000023 |
| checking permissions           | 0.000008 |
| checking permissions           | 0.000006 |
| init                           | 0.000014 |
| Opening tables                 | 0.000355 |
| setup                          | 0.000138 |
| creating table                 | 0.003776 |
| waiting for handler commit     | 0.000023 |
| waiting for handler commit     | 0.002787 |
| After create                   | 0.013048 |
| System lock                    | 0.000022 |
| copy to tmp table              | 0.001201 |
| waiting for handler commit     | 0.000019 |
| waiting for handler commit     | 0.000017 |
| waiting for handler commit     | 0.001505 |
| rename result table            | 0.000144 |
| waiting for handler commit     | 0.014814 |
| waiting for handler commit     | 0.000021 |
| waiting for handler commit     | 0.017625 |
| waiting for handler commit     | 0.000027 |
| waiting for handler commit     | 0.007083 |
| waiting for handler commit     | 0.000018 |
| waiting for handler commit     | 0.001853 |
| end                            | 0.021005 |
| query end                      | 0.001117 |
| closing tables                 | 0.000022 |
| waiting for handler commit     | 0.000029 |
| freeing items                  | 0.000049 |
| cleaning up                    | 0.000030 |
+--------------------------------+----------+
31 rows in set, 1 warning (0.00 sec)
```

> 4. Изучите файл my.cnf в директории /etc/mysql.
Измените его согласно ТЗ (движок InnoDB):
Скорость IO важнее сохранности данных,
Нужна компрессия таблиц для экономии места на диске,
Размер буффера с незакомиченными транзакциями 1 Мб,
Буффер кеширования 30% от ОЗУ,
Размер файла логов операций 100 Мб,
Приведите в ответе измененный файл my.cnf.

```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL
innodb_file_per_table       = 1
innodb_flush_method         = O_DSYNC
innodb_log_buffer_size = 1M
innodb_buffer_pool_size = 4800M
innodb_log_file_size = 100M

# Custom config should go here
!includedir /etc/mysql/conf.d/

```