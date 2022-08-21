# Домашнее задание к занятию "12.5 Сетевые решения CNI"

> Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования:

> * установка производится через ansible/kubespray;

> * после применения следует настроить политику доступа к hello-world извне. Инструкции kubernetes.io, Calico

При раскатке кластера проверяем что в *inventory\sample\group_vars\k8s_cluster* установлен параметр kube_network_plugin: calico

```
yc-user@node1:~$ sudo kubectl get nodes
NAME    STATUS   ROLES           AGE     VERSION
node1   Ready    control-plane   6m1s    v1.24.3
node2   Ready    <none>          4m59s   v1.24.3
node3   Ready    <none>          4m59s   v1.24.3
```

манифест для создания деплоймента с hello-world:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-deployment
spec:
  selector:
    matchLabels:
      app: hello
  replicas: 2
  template:
    metadata:
      labels:
        app: hello
    spec:
      containers:
      - name: hello
        image: k8s.gcr.io/echoserver:1.4
        ports:
        - containerPort: 8080
```

для публикации сервиса наружу через nodeport:

```
apiVersion: v1
kind: Service
metadata:
  name: hello-svc
  labels:
    app: hello
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  selector:
    app: hello
  type: NodePort

```

проверка ответа от приложения:

```
yc-user@node1:~$ curl http://10.129.0.7:31048
CLIENT VALUES:
client_address=10.233.102.128
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://10.129.0.7:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=10.129.0.7:31048
user-agent=curl/7.68.0
BODY:
-no body in request-

```

список сервисов кластера:

```
yc-user@node1:~$ sudo kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
hello-svc    NodePort    10.233.41.170   <none>        80:31048/TCP   17m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP        40m
```


> Задание 2: изучить, что запущено по умолчанию 


> Самый простой способ — проверить командой calicoctl get . Для проверки стоит получить список нод, ipPool и profile.
> Требования:
> *  установить утилиту calicoctl;
> * получить 3 вышеописанных типа в консоли.


```
yc-user@node1:~$ sudo calicoctl get nodes
NAME
node1
node2
node3

yc-user@node1:~$ sudo calicoctl get ipPool
NAME           CIDR             SELECTOR
default-pool   10.233.64.0/18   all()


yc-user@node1:~$ sudo calicoctl get profile
NAME
projectcalico-default-allow
kns.default
kns.kube-node-lease
kns.kube-public
kns.kube-system
ksa.default.default
ksa.kube-node-lease.default
ksa.kube-public.default
ksa.kube-system.attachdetach-controller
ksa.kube-system.bootstrap-signer
ksa.kube-system.calico-node
ksa.kube-system.certificate-controller
ksa.kube-system.clusterrole-aggregation-controller
ksa.kube-system.coredns
ksa.kube-system.cronjob-controller
ksa.kube-system.daemon-set-controller
ksa.kube-system.default
ksa.kube-system.deployment-controller
ksa.kube-system.disruption-controller
ksa.kube-system.dns-autoscaler
ksa.kube-system.endpoint-controller
ksa.kube-system.endpointslice-controller
ksa.kube-system.endpointslicemirroring-controller
ksa.kube-system.ephemeral-volume-controller
ksa.kube-system.expand-controller
ksa.kube-system.generic-garbage-collector
ksa.kube-system.horizontal-pod-autoscaler
ksa.kube-system.job-controller
ksa.kube-system.kube-proxy
ksa.kube-system.namespace-controller
ksa.kube-system.node-controller
ksa.kube-system.nodelocaldns
ksa.kube-system.persistent-volume-binder
ksa.kube-system.pod-garbage-collector
ksa.kube-system.pv-protection-controller
ksa.kube-system.pvc-protection-controller
ksa.kube-system.replicaset-controller
ksa.kube-system.replication-controller
ksa.kube-system.resourcequota-controller
ksa.kube-system.root-ca-cert-publisher
ksa.kube-system.service-account-controller
ksa.kube-system.service-controller
ksa.kube-system.statefulset-controller
ksa.kube-system.token-cleaner
ksa.kube-system.ttl-after-finished-controller
ksa.kube-system.ttl-controller
```