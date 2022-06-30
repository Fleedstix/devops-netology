<<<<<<< HEAD
# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"

## Задание 1: Подготовить инвентарь kubespray

> Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
> 
> * подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
> * в качестве CRI — containerd;
> * запуск etcd производить на мастере.

Создал хосты в яндекс облаке:

```
+----------------------+-----------+---------------+---------+---------------+-------------+
|          ID          |   NAME    |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP |
+----------------------+-----------+---------------+---------+---------------+-------------+
| ef36vtbvsb1jrtg2f56p | node1     | ru-central1-c | RUNNING | 51.250.35.115 | 10.130.0.20 |
| ef38i68mdfk1dfbh45ov | cp1       | ru-central1-c | RUNNING | 51.250.45.220 | 10.130.0.7  |
| ef3singgh3tttn202ivv | node2     | ru-central1-c | RUNNING | 51.250.34.176 | 10.130.0.32 |
+----------------------+-----------+---------------+---------+---------------+-------------+
```

Добавил их в hosts.yml в kubespray:


```
all:
  hosts:
    node1:
      ansible_host: 51.250.45.220
      ansible_user: yc-user
    node2:
      ansible_host: 51.250.35.115
      ansible_user: yc-user
    node3:
      ansible_host: 51.250.34.176
      ansible_user: yc-user
  children:
    kube_control_plane:
      hosts:
        node1:
    kube_node:
      hosts:
        node2:
        node3:
    etcd:
      hosts:
        node1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```


В extra_playbooks/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml прописано: 

```
container_manager: containerd
```


запустил плейбук:

```
ansible-playbook -i inventory/mycluster/hosts.yml cluster.yml -b -v --private-key=~/.ssh/id_rsa
```

Дождался выполнения: 

```
PLAY RECAP ***************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
node1                      : ok=748  changed=144  unreachable=0    failed=0    skipped=1247 rescued=0    ignored=9
node2                      : ok=497  changed=94   unreachable=0    failed=0    skipped=736  rescued=0    ignored=2
node3                      : ok=497  changed=94   unreachable=0    failed=0    skipped=735  rescued=0    ignored=2
```

Подключился на ноду:

```
ssh yc-user@51.250.45.220

yc-user@node1:~$ sudo kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
node1   Ready    control-plane   25m   v1.24.2
node2   Ready    <none>          23m   v1.24.2
node3   Ready    <none>          23m   v1.24.2
```

проверяем container runtime:

```
yc-user@node1:~$ sudo kubectl describe nodes node1 | grep container
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:////var/run/containerd/containerd.sock
  Container Runtime Version:  containerd://1.6.6
```


etcd установлен: 

```
yc-user@node1:~$ etcd --version
etcd Version: 3.5.4
Git SHA: 08407ff76
Go Version: go1.16.15
Go OS/Arch: linux/amd64
```
=======
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

>>>>>>> 6c30633cabddaaf9f56985c670558973bd13bbd1
