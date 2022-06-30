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
