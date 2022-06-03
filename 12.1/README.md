# Домашнее задание к занятию "12.1 Компоненты Kubernetes"


## Задача 1: Установить Minikube

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине Minikube.

```
fleedstix@testvm1:~$ minikube start --vm-driver=none
* minikube v1.25.2 on Ubuntu 20.04 (vbox/amd64)
* Using the none driver based on user configuration
* Starting control plane node minikube in cluster minikube
* Running on localhost (CPUs=4, Memory=7957MB, Disk=60432MB) ...
* OS release is Ubuntu 20.04.4 LTS
* Preparing Kubernetes v1.23.3 on Docker 20.10.14 ...
  - kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
  - kubelet.housekeeping-interval=5m
    > kubelet.sha256: 64 B / 64 B [--------------------------] 100.00% ? p/s 0s
    > kubectl.sha256: 64 B / 64 B [--------------------------] 100.00% ? p/s 0s
    > kubeadm.sha256: 64 B / 64 B [--------------------------] 100.00% ? p/s 0s
    > kubectl: 44.43 MiB / 44.43 MiB [-----------] 100.00% 280.26 MiB p/s 400ms
    > kubeadm: 43.12 MiB / 43.12 MiB [-----------] 100.00% 188.37 MiB p/s 400ms
    > kubelet: 118.75 MiB / 118.75 MiB [----------] 100.00% 133.41 MiB p/s 1.1s
  - Generating certificates and keys ...
  - Booting up control plane ...
  - Configuring RBAC rules ...
* Configuring local host environment ...
*
! The 'none' driver is designed for experts who need to integrate with an existing VM
* Most users should use the newer 'docker' driver instead, which does not require root!
* For more information, see: https://minikube.sigs.k8s.io/docs/reference/drivers/none/
*
! kubectl and minikube configuration will be stored in /home/fleedstix
! To use kubectl or minikube commands as your own user, you may need to relocate them. For example,
to overwrite your own settings, run:
*
  - sudo mv /home/fleedstix/.kube /home/fleedstix/.minikube $HOME
  - sudo chown -R $USER $HOME/.kube $HOME/.minikube
*
* This can also be done automatically by setting the env var CHANGE_MINIKUBE_NONE_USER=true
* Verifying Kubernetes components...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
* Enabled addons: default-storageclass, storage-provisioner
* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
fleedstix@testvm1:~$ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

fleedstix@testvm1:~$ kubectl get pods --namespace=kube-system
NAME                              READY   STATUS    RESTARTS   AGE
coredns-64897985d-sbb4d           0/1     Running   0          13s
etcd-testvm1                      1/1     Running   1          24s
kube-apiserver-testvm1            1/1     Running   1          24s
kube-controller-manager-testvm1   1/1     Running   1          24s
kube-proxy-rwlft                  1/1     Running   0          14s
kube-scheduler-testvm1            1/1     Running   1          24s
storage-provisioner               1/1     Running   0          23s
```
развернуть через Minikube тестовое приложение по туториалу


```
fleedstix@testvm1:~$ kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
deployment.apps/hello-node created
fleedstix@testvm1:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-ph54w   1/1     Running   0          17s
fleedstix@testvm1:~$ kubectl get deployments
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   1/1     1            1           31s
```

установить аддоны ingress и dashboard

```
fleedstix@testvm1:~$ minikube addons enable ingress
  - Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
  - Using image k8s.gcr.io/ingress-nginx/controller:v1.1.1
  - Using image k8s.gcr.io/ingress-nginx/kube-webhook-certgen:v1.1.1
* Verifying ingress addon...

* The 'ingress' addon is enabled
fleedstix@testvm1:~$
fleedstix@testvm1:~$ minikube addons enable dashboard
  - Using image kubernetesui/dashboard:v2.3.1
  - Using image kubernetesui/metrics-scraper:v1.0.7
* Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


* The 'dashboard' addon is enabled
```
Подготовить рабочую машину для управления корпоративным кластером. Установить клиентское приложение kubectl. подключиться к minikube

```
fleedstix@testvm1:~$ kubectl version --client
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"24", GitVersion:"v1.24.1", GitCommit:"3ddd0f45aa91e2f30c70734b175631bec5b5825a", GitTreeState:"clean", BuildDate:"2022-05-24T12:26:19Z", GoVersion:"go1.18.2", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.4
```

проверить работу приложения из задания 2, запустив port-forward до кластера

```
fleedstix@testvm1:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-6b89d599b9-ph54w   1/1     Running   0          23m
fleedstix@testvm1:~$ kubectl port-forward hello-node-6b89d599b9-ph54w 8080:8080
Forwarding from 127.0.0.1:8080 -> 8080
Forwarding from [::1]:8080 -> 8080
Handling connection for 8080
```
```
fleedstix@testvm1:~$ curl 127.0.0.1:8080
CLIENT VALUES:
client_address=127.0.0.1
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://127.0.0.1:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=127.0.0.1:8080
user-agent=curl/7.68.0
BODY:
-no body in request-
```