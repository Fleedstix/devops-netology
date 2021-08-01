# Домашнее задание по лекции "Командная оболочка Bash: практические навыки"

> 1. Есть скрипт:

```
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```
> Какие значения переменным c,d,e будут присвоены? Почему?
```
c = a+b
d = 1+2
e = 3
```


> 2. На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным. В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```
while ((1==1)
do
curl https://localhost:4757
if (($? != 0))
then
date >> curl.log
fi
done
```
```
while true
do curl https://localhost:4757
if [[ $? -ne 0 ]]
then
date >> curl.log
else
exit 1
fi
done
```

> 3. Необходимо написать скрипт, который проверяет доступность трёх IP: 192.168.0.1, 173.194.222.113, 87.250.250.242 по 80 порту и записывает результат в файл log. Проверять доступность необходимо пять раз для каждого узла.
```
#!/bin/bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
port=80
for host in ${hosts[*]}
do
for i in {1..5}
do
nc -zvw1 $host $port 2>&1 | sed 's/\r//g' | xargs >> nc.log
done
done
```
```
vagrant@vagrant:~$ cat nc.log
nc: connect to 192.168.0.1 port 80 (tcp) timed out: Operation now in progress
nc: connect to 192.168.0.1 port 80 (tcp) timed out: Operation now in progress
nc: connect to 192.168.0.1 port 80 (tcp) timed out: Operation now in progress
nc: connect to 192.168.0.1 port 80 (tcp) timed out: Operation now in progress
nc: connect to 192.168.0.1 port 80 (tcp) timed out: Operation now in progress
nc: connect to 192.168.0.1 port 80 (tcp) timed out: Operation now in progress
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 173.194.222.113 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
Connection to 87.250.250.242 80 port [tcp/http] succeeded!
```
> 4. Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается

```
#!/bin/bash

hosts=(173.194.222.113 87.250.250.242 192.168.0.1)
port=80

for host in "${hosts[*]}"
do
for i in {1..5}
do
if echo "Hi from scanner at $(uname -n)" 2>/dev/null > /dev/tcp/"$host"/"$port"
then
echo success at "$host":"$port" >> nc.log
else
echo failure at "$host":"$port" >> nc.log
exit 1
fi
done
done
```
```
vagrant@vagrant:~$ cat nc.log
success at 173.194.222.113:80
success at 173.194.222.113:80
success at 173.194.222.113:80
success at 173.194.222.113:80
success at 173.194.222.113:80
success at 87.250.250.242:80
success at 87.250.250.242:80
success at 87.250.250.242:80
success at 87.250.250.242:80
success at 87.250.250.242:80
failure at 192.168.0.1:80
```