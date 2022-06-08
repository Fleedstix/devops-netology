# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"

Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

```
fleedstix@testvm1:~$ kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.10
deployment.apps/hello-node created
fleedstix@testvm1:~$ kubectl scale deployment hello-node --replicas=2
deployment.apps/hello-node scaled
fleedstix@testvm1:~$ kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   2/2     2            2           4m20s
fleedstix@testvm1:~$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
hello-node-85dc9448bd-prd4s   1/1     Running   0          4m26s
hello-node-85dc9448bd-s8dzp   1/1     Running   0          13s
```

> Задание 2: Просмотр логов для разработки 
> азработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
> ребуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.
> 
> ребования: 
> * создан новый токен доступа для пользователяs
> * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
> * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)


Создание закрытого ключа и запроса на подпись сертификата (CSR)
```
openssl genrsa -out dave.key 4096
openssl req -config ./csr.cnf -new -key dave.key -out dave.csr
```
cat csr.cnf:
```
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[ dn ]
CN = dave
O = dev

[ v3_ext ]
authorityKeyIdentifier=keyid,issuer:always
basicConstraints=CA:FALSE
keyUsage=keyEncipherment,dataEncipherment
extendedKeyUsage=serverAuth,clientAuth
```



Подписание CSR

```
fleedstix@testvm10:~$ cat csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
 name: mycsr
spec:
 request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJRVlqQ0NBa29DQVFBd0hURU5NQXNHQTFVRUF3d0VaR0YyWlRFTU1Bb0dBMVVFQ2d3RFpHVjJNSUlDSWpBTgpCZ2txaGtpRzl3MEJBUUVGQUFPQ0FnOEFNSUlDQ2dLQ0FnRUF4M3U3cmRzYjJCbzZuUExSdkgwZGcvUmNBNlB2CnpRQTZ0QzU4anNhZjg5aC9LVzRTZXp5VkY3cy8xNmQvVkF3d1dTYjZPUjdMemdJL2xjZXRvM2lTQTBsbnpZNmYKWS8wMWkwdllnQ01iTDZ6M2p6SkRMYjJUcDA1cFZhOWNYdXh4ZTBVRTFFY2FINTNGNjcvSi96MnI3SVlHbUd3agpxYTZIdjhURkFUQ3JDb3F2YXoyUWttU3M3aHZJYXk4TjJYdWtkV0pLZEVPTm5iLytremlYd2lSVEpFY1AzaDJiCmhybmU2dlEyNmNCb2NpMVRRc1pldzJ0Witic3U5M0VBUk5HcGhSRjdQc2VkVjVBQ3QxRVhmWHNkTXVjQWh1QWsKcWdra0J6dnFMV2pzN25zYlBlY3NPQnppelQ1bVBLMnRJVkMwZ01vdkNQZlFMZWpQWEIwUUxiZjFYSTRzM1VubQplYUZTY3BwM2lTLzRhMkNRdS9ENnNwR0ZOMmpSRkpKV0FDckhMZ0dkdmhjWkpWT1B2ajhWSDNGeGRBcGZEa2pYCnErYmdpSXRPR1FnOHlxeityak5vN2NkaktldlRIbDJmZTRUM0JVTVdGT0FyazE4RUtvZFM1UmltMlpTUVptT3cKSlhmSzRKU3krYURHWWE5VmdrZ3dxd3hSZFZJZVhnS2JYZFZ1SjRHYndVdVRUN3dSb2NTYVB1VVdvMUROV282SgpUS0ZKNTVaa3luSWZmRFFocFkyOFVLKzdFZ3NpL3lzaTg3Y0VQM1BaR01VN1l6T1lVaHorM01wL0hGaDNHZ2JTClJZaHl2dGx3R09VZFJ5bTNMMUNqVFlEeklKNEZtU0diTHY3cWZYN21Ra3FFVFU4ZG5TamdJU1FwN09mR01ROVEKSjNMaDVxY2xKRFdjVTkwQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQkN3VUFBNElDQVFDa3JVUkZkZlF0SkVyYQpzNmZQL2xONDcwNWdIbmVCREpTUUVRQ1pCU0Rid3lXQk1OZ0pqVHRFeWwyUjBzWC9lMGt0MFdNeHZ3ZlIvUndYCjI2NlVlUk1UTFcybkN3UDlrR0huY2VSNTRrelhONW1iYjM1ZlN3eHduUmNOZENkZnhXalpQSFZISTNDaUhkem8KUXhTMEU2RnZRcTBmZzBIaGlqRDVDRVNieUFJdnpCc2Rqd1RtdW9sdVh4R0RRekF5YjJLWU1GV1IzMXJuK3NRegpBcVhnSnJ2cjFzYWJwTThVM25xcHBFV2N1Q0cxcm14K3dleUZST1VCcFUyaTM5VlhDNXB3eHVuWklBN25qMkRUCkZnMXVoNy9vbXVQTXFCZXZPaFpxU0NQNEI0QWEzMVQwSVl6MmJydDh3MVVmQk5hVmtvZmEraStJOHRzcnlZYkIKbzdSYXM5Y1JrTVN1Y1QybDhadjZIaEJIRzh5Yld5NC9pdE1pMUlGRmRvNDNTWk5qbGxZN2lqS0NUUE1odi9pOAo4c2hKMnVUa0RGNHZUWDF2bnIzUmgrQ0NzZER2cUs2WXp6MEt0QlI5Rlh3NlNrdWlSQXUvQ3h3UE1HclJXYUNTCkFnM2wwNUZTODd2OSttS0tNMGRzZGx4bm5qOFQ3WXhSeVlFa0h5N3pjbytJUWZVZm9Oam1EdzVKOXAwSExhTi8KalJjZ1RCNU1mVGZHZTJZbnR0TnlkYTFJZ0RMeWNnMHVMSmZKQ0lRQjBDOWVWWS91SlA4YVd5OFdsYnl1VVJUZgpFVEZ4cUdkanFxbkdKaEY1NHJvMnREaURTdG5sY28rUE05b0E5ZytuTzI5SDJOekNiOWZtQ3FybzBmcy9VdTdDCk5sL2hleDZtNnVZWS85YkNvSG42SFUwTkdxekxvUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
 signerName: kubernetes.io/kube-apiserver-client
 expirationSeconds: 86400  # one day
 usages:
  - client auth
  ```

```
fleedstix@testvm1:~/test$ kubectl apply -f myuser.yaml
certificatesigningrequest.certificates.k8s.io/myuser created
fleedstix@testvm1:~/test$ kubectl get csr
NAME     AGE   SIGNERNAME                            REQUESTOR       REQUESTEDDURATION   CONDITION
myuser   48s   kubernetes.io/kube-apiserver-client   minikube-user   24h                 Pending
fleedstix@testvm1:~/test$ kubectl certificate approve myuser
certificatesigningrequest.certificates.k8s.io/myuser approved
fleedstix@testvm1:~/test$ kubectl get csr
NAME     AGE   SIGNERNAME                            REQUESTOR       REQUESTEDDURATION   CONDITION
myuser   85s   kubernetes.io/kube-apiserver-client   minikube-user   24h                 Approved,Issued
fleedstix@testvm1:~/test$ kubectl get csr myuser -o jsonpath='{.status.certificate}'  | base64 --decode > myuser.crt
```

Создание роли:

```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
 namespace: development
 name: dev
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "view", "list"]
```

Связывание роли с пользователем

```
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev
  namespace: development
subjects:
- kind: User
  name: dave
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: dev
  apiGroup: rbac.authorization.k8s.io
```

kubeconfig:
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/fleedstix/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Wed, 08 Jun 2022 13:34:39 UTC
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: cluster_info
    server: https://192.168.49.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Wed, 08 Jun 2022 13:34:39 UTC
        provider: minikube.sigs.k8s.io
        version: v1.25.2
      name: context_info
    namespace: development
    user: dave
  name: dave-minikube
current-context: dave-minikube
kind: Config
preferences: {}
users:
- name: dave
  user:
    client-certificate: /home/fleedstix/mycsr.crt
    client-key: /home/fleedstix/dave.key
```

переход в контекст созданного пользователя:

```
fleedstix@testvm10:~$ export KUBECONFIG=$PWD/kubeconfig
```

Проверка прав:

```
fleedstix@testvm10:~$ kubectl get pods --namespace=development
NAME                   READY   STATUS    RESTARTS   AGE
www-84678bd648-rvl5h   1/1     Running   0          33m
www-84678bd648-trx7n   1/1     Running   0          33m
www-84678bd648-zxfvq   1/1     Running   0          10m
fleedstix@testvm10:~$ kubectl get pods --namespace=default
Error from server (Forbidden): pods is forbidden: User "dave" cannot list resource "pods" in API group "" in the namespace "default"
fleedstix@testvm10:~$ kubectl delete pod www-84678bd648-zxfvq --namespace=development
Error from server (Forbidden): pods "www-84678bd648-zxfvq" is forbidden: User "dave" cannot delete resource "pods" in API group "" in the namespace "development"
fleedstix@testvm10:~$ kubectl logs www-84678bd648-zxfvq --namespace=development --v=5
I0608 14:51:00.876149   40939 cert_rotation.go:137] Starting client certificate rotation controller
I0608 14:51:00.903884   40939 helpers.go:222] server response object: [{
  "metadata": {},
  "status": "Failure",
  "message": "pods \"www-84678bd648-zxfvq\" is forbidden: User \"dave\" cannot get resource \"pods/log\" in API group \"\" in the namespace \"development\"",
  "reason": "Forbidden",
  "details": {
    "name": "www-84678bd648-zxfvq",
    "kind": "pods"
  },
  "code": 403
}]
Error from server (Forbidden): pods "www-84678bd648-zxfvq" is forbidden: User "dave" cannot get resource "pods/log" in API group "" in the namespace "development"
fleedstix@testvm10:~$ kubectl describe pod  www-84678bd648-zxfvq --namespace=development --v=5
I0608 14:51:36.336235   41025 cert_rotation.go:137] Starting client certificate rotation controller
Name:         www-84678bd648-zxfvq
Namespace:    development
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Wed, 08 Jun 2022 14:39:32 +0000
Labels:       app=www
              pod-template-hash=84678bd648
Annotations:  <none>
Status:       Running
IP:           172.17.0.3
IPs:
  IP:           172.17.0.3
Controlled By:  ReplicaSet/www-84678bd648
Containers:
  nginx:
    Container ID:   docker://9340b9b0d602ac247ecae72c487f426fd142ed0a4d25d9cbe71fcee78b7bf491
    Image:          nginx:1.14-alpine
    Image ID:       docker-pullable://nginx@sha256:485b610fefec7ff6c463ced9623314a04ed67e3945b9c08d7e53a47f6d108dc7
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 08 Jun 2022 14:39:33 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xs9wr (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-xs9wr:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>

fleedstix@testvm10:~$ kubectl scale deployment www --replicas=5  --namespace=development
Error from server (Forbidden): deployments.apps "www" is forbidden: User "dave" cannot get resource "deployments" in API group "apps" in the namespace "development"
```

Проверка под minikube:

```
fleedstix@testvm10:~$ export KUBECONFIG=~/.kube/config
fleedstix@testvm10:~$ kubectl scale deployment www --replicas=5  --namespace=development
deployment.apps/www scaled
```

> ## Задание 3: Изменение количества реплик 
> Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив > количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 
> 
> Требования:
>  * в deployment из задания 1 изменено количество реплик на 5
>  * проверить что все поды перешли в статус running (kubectl get pods)

```
fleedstix@testvm1:~/test$ kubectl scale deployment hello-node --replicas=5
deployment.apps/hello-node scaled
fleedstix@testvm1:~/test$ kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   3/5     5            3           2d1h
fleedstix@testvm1:~/test$ kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hello-node   5/5     5            5           2d1h
```


