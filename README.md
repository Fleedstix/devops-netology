# Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

> 1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
> * поместите его в автозагрузку,
> * предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
> * удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz

tar xvfz node_exporter-*.*-amd64.tar.gz

sudo mv node_exporter-1.1.2.linux-amd64/node_exporter /usr/local/bin/

sudo vi /etc/systemd/system/node_exporter.service



[Unit]
Description=Node Exporter
After=network.target
 
[Service]
EnvironmentFile=-/etc/default/node_exporter
User=root
Group=root
Type=simple
ExecStart=/usr/local/bin/node_exporter
 
[Install]
WantedBy=multi-user.target



sudo systemctl daemon-reload
sudo systemctl start node_exporter

root@vagrant:/etc/systemd/system# sudo systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; disabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-07-08 17:13:01 UTC; 3s ago
   Main PID: 1113 (node_exporter)
      Tasks: 4 (limit: 2280)
     Memory: 2.2M
     CGroup: /system.slice/node_exporter.service
             └─1113 /usr/local/bin/node_exporter

Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=thermal_zone
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=time
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=timex
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=udp_queues
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=uname
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=vmstat
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.261Z caller=node_exporter.go:113 collector=xfs
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.262Z caller=node_exporter.go:113 collector=zfs
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.262Z caller=node_exporter.go:195 msg="Listening on" address=:9100
Jul 08 17:13:01 vagrant node_exporter[1113]: level=info ts=2021-07-08T17:13:01.262Z caller=tls_config.go:191 msg="TLS is disabled." http2=false
```
> 2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

/metrics выводятся в веб интерфейс по адресу http://адрес_сервера:9100/metrics

опции:

* --collector.cpu
* --collector.meminfo
* --collector.diskstats
* --collector.netstat

>3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:
в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:
config.vm.network "forwarded_port", guest: 19999, host: 19999
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

Настройка выполнена, метрики стали доступны в веб-интерфейсе
![netdata](/images/netdata.png)


>4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Можно, dmesg говорит что на машине используется BIOS VirtualBox

[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000] Hypervisor detected: KVM

>5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

Параметр fs.nr_open означает лимит количества открытых дескрипторов
fs.nr_open = 1048576

Другой существующий лимит
vagrant@vagrant:~$ ulimit -n
1024

> 6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

```
root@vagrant:~# unshare -f --pid --mount-proc /bin/bash
root@vagrant:~# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.1   9836  3912 pts/1    S    20:25   0:00 /bin/bash

root@vagrant:/# ps aux | grep bash
root       16480  0.0  0.0   8080   528 pts/1    S    20:25   0:00 unshare -f --pid --mount-proc /bin/bash
root       16481  0.0  0.1   9836  3912 pts/1    S+   20:25   0:00 /bin/bash

root@vagrant:/# nsenter --target 16481 --pid --mount
root@vagrant:/# ps aux 
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.1   9836  3912 pts/1    S    20:25   0:00 /bin/bash
```
>7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

Данная команда вызывает функцию, которая запускает два своих экземпляра, каждый экземпляр ещё по два, таким образом колличетсво экземпляра растёт в прогрессии.

Когда колличество процессов достигает лимита ulimit -u, функция более не может создавать свои экземпляры

изменить число процессов, которое можно создать в сессии можно в файле /etc/security/limits.conf

строкой 

*(пользователь) hard(тип ограничения жесткое/мягкое) nproc(процессы) 50(наш задаваемый лимит)





