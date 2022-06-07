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
openssl genrsa -out myuser.key 4096
openssl req -config ./csr.cnf -new -key myuser.key -out myuser.csr
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
fleedstix@testvm1:~/test$ cat myuser.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1lqQ0NBVW9DQVFBd0hURU5NQXNHQTFVRUF3d0VaR0YyWlRFTU1Bb0dBMVVFQ2d3RFpHVjJNSUlCSWpBTgpCZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUExdHpzK1RmQUFaWmhxck5LM2g4bHJwdDZRZkp2ClpVNjNNSmo1a2Q4QzAyQUZPWnhVay9nQW5mWUlraldLajdseVRub0lHdTdwSHpNNGZ1M296VzNOcHdzZXFhc28KUjBJOXhPTlZxcWRmTHhRZHUvay9zOWRjTE1mbkVXakMxSzNJd3BzK1hheE5HejRuWkQyQzlGYnRPVHkyMFBESgpwU2Q0TGtzUjlMenJHYUEzazUyWGdtZFhRaWp5clI5ZTJGTmplL1FWVm53TEc3VzlCektOdU91M2R0VXdwZlk1CjRVZkFoYUVobVJ0UXFuOVk0V2l4NUlNcHl3YWJ1MFYydG9CallCOTRNM21CYnI4VTcvZGlpNldGS2MzTjQ3YkIKMnNPU2htcjFrYk9SQS85UHBWZVhhVTNBZENaZ3hNTWdzc2JpUnBkN1BvSVlUU0JOYjJRcFE5cDZid0lEQVFBQgpvQUF3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUVZcVRpVmtwUDVGY25uVVBiV0V0TGRXUWx5TVhqRUs0dHE1CmdoWkVncnlnMDErTTI4dmRkUEhObEhJb1hHbVRZWkFDaFhrSEJ3Q3l0L1B4WDYvaG0zTDQzZStJbHUreEFsNmYKbDM0TXFaN2cyMmFOU0hEbGJPWEl4RkdMV0lYMzl2czhxMkd1YWl0eWNqTlNUV3Z1eWlDU0FzNTNvSXZFOEdtVQp2WnJpdmlQQm5rdjlnTE05RDg0US9zdnJvTHc1YWlZMHlPdlJPazhyY1J4Mzh4UU5ML1NlY3lqWkg3czdFdnpYCmI4YURZTzlBbU9zemdQVEdrTlhFc0lLTTVudGRCS0JWb0tmdGlwYUlOYVlGN3Fyb1RaUlFtTUl1am1EYVBDc3oKK3g0eTRFTEtTU1BjcjhFS1dSR0x1OHRFZU9seGVRelE3cGpyb1ZZdXFSbzg2L2xWakxFPQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K
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
 namespace: app-namespace
 name: dev
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["logs", "describe"]
```

Связывание роли с пользователем

```
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev
  namespace: app-namespace
subjects:
- kind: User
  name: myuser
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: dev
  apiGroup: rbac.authorization.k8s.io
```

kubeconfig:
```
apiVersion: v1
kind: Config
clusters:
- cluster:
   certificate-authority-data: ${CLUSTER_CA}
   server: ${CLUSTER_ENDPOINT}
 name: ${CLUSTER_NAME}
users:
- name: ${USER}
 user:
   client-certificate-data: ${CLIENT_CERTIFICATE_DATA}
contexts:
- context:
   cluster: ${CLUSTER_NAME}
   user: dave
 name: ${USER}-${CLUSTER_NAME}
current-context: ${USER}-${CLUSTER_NAME}
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


