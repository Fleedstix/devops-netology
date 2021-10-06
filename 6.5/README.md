# Домашнее задание к занятию "6.5. Elasticsearch"

> 1. Используя докер образ centos:7 как базовый и документацию по установке и запуску Elastcisearch: составьте Dockerfile-манифест для elasticsearch, соберите docker-образ и сделайте push в ваш docker.io репозиторий, запустите контейнер из получившегося образа и выполните запрос пути / c хост-машины
Требования к elasticsearch.yml:
данные path должны сохраняться в /var/lib,
имя ноды должно быть netology_test

>cсылку на образ в репозитории dockerhub

https://hub.docker.com/repository/docker/fleedstix/elastic


>текст Dockerfile манифеста

[Dockerfile](./1/Dockerfile)


>ответ elasticsearch на запрос пути / в json виде

```
$ curl -X GET localhost:9200/
{
  "status" : 200,
  "name" : "netology_test",
  "version" : {
    "number" : "1.3.1",
    "build_hash" : "2de6dc5268c32fb49b205233c138d93aaf772015",
    "build_timestamp" : "2014-07-28T14:45:15Z",
    "build_snapshot" : false,
    "lucene_version" : "4.9"
  },
  "tagline" : "You Know, for Search"
}
```

>2. В этом задании вы научитесь: создавать и удалять индексы, изучать состояние кластера
, обосновывать причину деградации доступности данных.
Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:
```
Имя	Количество реплик	Количество шард
ind-1	     0	                   1
ind-2	     1	                   2
ind-3	     2	                   4
```
```
curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "index": {
    "number_of_shards": 4,  
    "number_of_replicas": 2 
  }
}
'
```

> Получите список индексов и их статусов, используя API и приведите в ответе на задание.
```
$ curl 'localhost:9200/_cat/indices?v'
health index pri rep docs.count docs.deleted store.size pri.store.size
yellow ind-2   2   1          0            0       230b           230b
yellow ind-3   4   2          0            0       460b           460b
green  ind-1   1   0          0            0       115b           115b
```

>Получите состояние кластера elasticsearch, используя API.

```
$ curl http://127.0.0.1:9200/_cluster/health?pretty
{
  "cluster_name" : "elasticsearchcluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10
}
```

> Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Желтый означает что, все осколки доступны, но вот реплики не все. В этом случае любые запросы к индексу все же возвращаются с правильными результатами, но если узел, содержащий мастер осколок, упадет, могут потеряться данные.
Так же желтый может означать не верные настройки конфигурации.

>Удалите все индексы.
```

$ curl -X DELETE "localhost:9200/ind-3?pretty"
{
  "acknowledged" : true
}

$ curl -X DELETE "localhost:9200/ind-2?pretty"
{
  "acknowledged" : true
}


$ curl -X DELETE "localhost:9200/ind-1?pretty"
{
  "acknowledged" : true
}
```

>3. Создайте директорию {путь до корневой директории с elasticsearch в образе}/snapshots
>Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.
>Приведите в ответе запрос API и результат вызова API для создания репозитория.

```
$ curl -XPUT 'http://localhost:9200/_snapshot/netology_backup?pretty=true' -d '{"type":"fs","settings":{"compress":true,"location":"/usr/share/elasticsearch/snapshots"}}'
{
  "acknowledged" : true
}
```
>Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.

```
curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
{
  "index": {
    "number_of_shards": 1,  
    "number_of_replicas": 0 
  }
}
'
```
```
$ curl 'localhost:9200/_cat/indices?v'
health index pri rep docs.count docs.deleted store.size pri.store.size
green  test    1   0          0            0       115b           115b
```
>Создайте snapshot состояния кластера elasticsearch.
```

$ curl -X PUT "localhost:9200/_snapshot/netology_backup/snapshot_2?wait_for_completion=true&pretty"
{
  "snapshot" : {
    "snapshot" : "snapshot_2",
    "indices" : [ "test" ],
    "state" : "SUCCESS",
    "start_time" : "2021-10-06T20:01:28.791Z",
    "start_time_in_millis" : 1633550488791,
    "end_time" : "2021-10-06T20:01:28.831Z",
    "end_time_in_millis" : 1633550488831,
    "duration_in_millis" : 40,
    "failures" : [ ],
    "shards" : {
      "total" : 1,
      "failed" : 0,
      "successful" : 1
    }
  }
}
```

>Приведите в ответе список файлов в директории со snapshotами.
```
[root@elasticsearch snapshots]# ls
index  indices   metadata-snapshot_2   snapshot-snapshot_2
```
> Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.
```
$ curl 'localhost:9200/_cat/indices?v'
health index  pri rep docs.count docs.deleted store.size pri.store.size
green  test-2   1   0          0            0       115b           115b
```
>Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.
>Приведите в ответе запрос к API восстановления и итоговый список индексов.
```

$ curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_2/_restore?pretty"
{
  "accepted" : true
}

$ curl 'localhost:9200/_cat/indices?v'
health index  pri rep docs.count docs.deleted store.size pri.store.size
green  test     1   0          0            0        79b            79b
green  test-2   1   0          0            0       115b           115b
```