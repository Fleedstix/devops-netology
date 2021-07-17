# Домашнее задание к занятию «2.1. Системы контроля версий.»
в папке Terraform Будут игнорироваться файлы crash.log, override.tf, override.tf.json, terraform.rc, любые файлы с расширением tfstate, tfvars, terraformrc,любые файлы которые заканчиваются на _override.tf, _override.tf.json или где середина файла соответствует .tfstate., а также все файлы в директории .terraform

# Домашнее задание к занятию «2.4. Инструменты Git»
1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.
> git show aefea

>    commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
    Update CHANGELOG.md
2. Какому тегу соответствует коммит 85024d3?
> git show 85024d3

> (tag: v0.12.23)
3. Сколько родителей у коммита b8d720? Напишите их хеши.
> git show b8d720

>  Два родителя, т.к это мердж коммит

> git show b8d720^

> 56cd7859e05c36c06b56d013b55a252d0bb7e158

>git show b8d720^2

> 9ea88f22fc6269854151c571162c5bcf958bee2b
4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.
> git show --oneline v0.12.23..v0.12.24

> b14b74c4939dcab573326f4e3ee2a62e23e12f89
    [Website] vmc provider links

> 3f235065b9347a758efadc92295b540ee0a5e26e
    Update CHANGELOG.md

> 6ae64e247b332925b872447e9ce869657281c2bf
    registry: Fix panic when server is unreachable
    Non-HTTP errors previously resulted in a panic due to dereferencing the
    resp pointer while it was nil, as part of rendering the error message.
    This commit changes the error message formatting to cope with a nil
    response, and extends test coverage.
    Fixes #24384

> 5c619ca1baf2e21a155fcdb4c264cc9e24a2a353
    website: Remove links to the getting started guide's old location
    Since these links were in the soon-to-be-deprecated 0.11 language section, I
    think we can just remove them without needing to find an equivalent link.

> 06275647e2b53d97d4f0a19a0fec11f6d69820b5
    Update CHANGELOG.md

> d5f9411f5108260320064349b757f55c09bc4b80
    command: Fix bug when using terraform login on Windows

> 4b6d06cc5dcb78af637bbb19c198faff37a066ed
    Update CHANGELOG.md

> dd01a35078f040ca984cdd349f18d0b67e486c35
    Update CHANGELOG.md

> 225466bc3e5f35baa5d07197bbc079345b77525e
    Cleanup after v0.12.23 releasec
5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).
> Ищу файл где создается функция providerSource

> git grep -n providerSource

> Функций создается в файле provider_source.go, делаю поиск по изменению функции

> git log -L :providerSource:provider_source.go

> Функция создается в коммите
> 8c928e83589d90a031f811fae52a81be7153e82f
6. Найдите все коммиты в которых была изменена функция globalPluginDirs
> Ищу файл где создается функция globalPluginDirs

>git grep -n globalPluginDirs

> Функция создается в файле plugins.go, делаю поиск по изменениям функции

>git log -L :globalPluginDirs:plugins.go

> 8364383c359a6b738a436d1b7745ccdce178df47

> 66ebff90cdfaa6938f26f908c7ebad8d547fea17

> 41ab0aef7a0fe030e84018973a64135b11abcd70

> 52dbf94834cb970b510f2fba853a5b49ad9b1a46

> 78b12205587fe839f10d946ea3fdc06719decb05

7. Кто автор функции synchronizedWriters?
> Ищу когда функция была добавлена или удалена из кода

> git log -S synchronizedWriters

> Функция была создана автором: Martin Atkins <mart@degeneration.co.uk>


# Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"
### 1-4. 
```
C:\Users\pvdil\Desktop\netology-sys>vagrant status
Current machine states:

default                   running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.
```
---
> 5.  Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?

По умолчанию выделено 1024 мб Оперативной памяти и 2 ядра процессора
![VirtualBox](/images/vbox.png)

---

> 6. Ознакомьтесь с возможностями конфигурации VirtualBox через Vagrantfile: документация. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

Размер оперативной памяти изменяется параметрами memory и cpu
```ruby
Vagrant.configure("2") do |config|
config.vm.box = "bento/ubuntu-20.04"
config.memory = 
config.cpu = 
```
---
> 8. Ознакомиться с разделами man bash, почитать о настройках самого bash: 
> * какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?
> * что делает директива ignoreboth в bash?
---

 Длина журнала задается переменной 
 ``` export HISTSIZE = ``` < число строк> , 843 строка в man bash                
 
  директива ignoreboth передает указания  не сохранять строки начинающиеся с символа <пробел> и не сохранять строки, совпадающие с последней выполненной командой.

---

> 9. В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?

В фигурные скобки используются для защиты переменной, от символов переменной следующих сразу за ним,что может быть интерпретированно как часть имени. Скобки необходимы когда параметр является позиционным параметром. В мануале описание скобок начинается с 1158 строки.

---
> 10. Основываясь на предыдущем вопросе, как создать однократным вызовом touch 100000 файлов? А получилось ли создать 300000?
 100000 файлов можно создать используя команду 
```bash
touch $(awk 'BEGIN { for(i=1;i<=100000;i++) printf "%d\n", i }')
```
создать больше 100000 файлов нельзя, т.к bash выдает ошибку 
```bash
-bash: /usr/bin/touch: Argument list too long
```
p.s оказалось все же возможно создать 300000 файлов, необходимо изменить предельные значения сценариев через команду ```ulimit -s <значение>```

---
> 11. В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]

 Конструкция  [[ -d /tmp ]] возвращает 1 или 0 в соответствии с тем, существует ли директория /tmp

---
> 12. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:

> bash is /tmp/new_path_directory/bash

> bash is /usr/local/bin/bash

> bash is /bin/bash


необходимо создать директорию new_path_directory в /tmp и скопировать туда исполняемый файл bash
```bash
mkdir /tmp/new_path_directory
cp /bin/bash /tmp/new_path_directory/bash
```
Аналогично с /usr/local/bin/bash
```bash 
mkdir /usr/local/bin
cp /bin/bash /usr/local/bin/bash
```
Далее прописываем в /etc/environment,
в переменную PATH директории /tmp/new_path_directory и /usr/local/bin после первых кавычек: 
```bash 
PATH="/tmp/new_path_directory:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin" 
```
Таким образом сначала будут получены эти директории

Перечитываем файл environment
```bash
source /etc/environment
```
Теперь ```bash type -a ``` bash выводит список,в соответствии с требованием задания 12:
```bash vagrant@vagrant:/usr/local/bin$ type -a bash
 bash is /tmp/new_path_directory/bash
 bash is /usr/bin/bash
 bash is /bin/bash
```

---
> 13. Чем отличается планирование команд с помощью batch и at?

 at используется для назначения одноразового задания на заданное время, а команда batch — для назначения одноразовых задач, которые должны выполняться, когда загрузка системы становится меньше 0,8 (или значение, указанное в atd)


# Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"

> 1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.

cd типа shell builtin, команда является встроенной, думаю в связи с тем, что cd напрямую управляет средой выполнения оболочки.

---

> 2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l? man grep поможет в ответе на этот вопрос. Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.
```
grep -c <some_string> <some_file> 
```
Выдает колличество строк содержащих образец 

---

> 3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?

/sbin/init

---

> 4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
```
sudo ls > /dev/pts/0
```
---

> 5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
```
echo "hello world" > 1 | cat 1 > 2 
```
---

> 6. Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?

sudo echo hello > /dev/tty1, да, смогу наблюдать даннные если переключусь и отправлю данные на один и тот же tty

---

> 7. Выполните команду bash 5>&1. К чему она приведет? 

Создасться новый файловый дескриптор с перенаправвлением его на 1 - stdout. 

---

> Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?

Вывод текста echo с перенаправлением на созданный нами файловый дескриптор 5, который в свою очередь перенаправляет поток в дескриптор 1 - стандартный вывод.

---

> 8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.

3>&1 1>&2 2>&3
В таком случае stderr станет доступен в качестве stdout

---

> 9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?

Выводит переменные окружения процесса текущего экземляра оболочки. Можно получить переменные построчно командой сstrings /proc/$$/environ

---

> 10. Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.

/proc/<PID>/cmdline содержит полную командрную строку запуска процесса кроме процессов в свопе и зомби процессов
/proc/<PID>/exe содержит фактическое полное имя выполняемого файла

---

> 11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.

```bash
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni ssse3 pcid sse4_1 sse4_2 hypervisor lahf_lm invpcid_single pti fsgsbase invpcid md_clear flush_l1d arch_capabilities
```

Самая старшая версия набора SSE - sse4_2

---

> 12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Однако:

```bash
vagrant@netology1:~$ ssh localhost `tty`
not a tty
```
Потому что при подключении по ssh мы попадаем на скрипт авторизации ssh, и tty для нас ещё не выделен. Изменить поведение можно передав параметр -t 

``` 
ssh -t localhost 'tty''
```

---

> 13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.

1. запускаю во второй сессии screen
2. в первом терминале выполняю ps -ef, нахожу PID screen во второй сессии
3. перемещаю процесс командой sudo reptyr -T $PID  (-T используется для поиска эмулятора терминала)

---

> 14. sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.

```sudo echo string > /root/new_file``` завершится с ошибкой потому что  sudo не выполняет перенаправление вывода, это произойдет как непривилегированный пользователь.

а в случае с командой ```echo string | sudo tee /root/new_file```, tee получит вывод команды echo и повысит права sudo и запишет в файл.

# Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. > Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd.

К cd относится системный вызов chdir("/tmp")

2. > Попробуйте использовать команду file на объекты разных типов на файловой системе. Например: ``` vagrant@netology1:~$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:~$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:~$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64 ```
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.

/usr/share/misc/magic файл определения типов

3. > Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

Необходимо найти файловый дескриптор удаленного файла и обнулить файл.

находим процессы где файлы помечены как deleted
```
lsof | grep deleted
```
и видим PID, FD процесса, и местоположение файла
```
[root@vagrant:/opt/kafka/logs]$ lsof | grep deleted
 COMMAND  PID     USER   FD   TYPE DEVICE SIZE/OFF NLINK   NODE NAME
 java    1763     root   4r   REG  252,1   255986     0 262629 /opt/kafka/log/huge-file.log (deleted)
```
можем просмотреть информацию по процессу ps -p 1763

Укорачиваем файл до 0 байт
```
sudo truncate -s 0 /proc/1763/fd/4
```


4. > Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

Нет, не занимает. При завершении процесс освобождает все свои ресурсы, остается только запись со статусом завершения в таблице процессов.

5. > В iovisor BCC есть утилита opensnoop:
``` 
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc 
```
> На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.

За первую секунду работы утилиты нет ниодного вызова к файлу группы open, за 5,10,30,60 секунд нет вызова тоже

```
root@vagrant:/usr/sbin# ./opensnoop-bpfcc -d 1 -n open
PID    COMM               FD ERR PATH
```

6. > Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

Системный вызов
uname({sysname="Linux", nodename="vagrant", ...})

man uname:
```
--version
output version information and exit
```
cat /proc/version

```
Linux version 5.4.0-73-generic (buildd@lcy01-amd64-019) (gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)) #82-Ubuntu SMP Wed Apr 14 17:39:42 UTC 2021
```

7. > Чем отличается последовательность команд через ; и через && в bash? Например:
```
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#
```
Выполняя команды через && Вторая команда начнет своё выполнение только если первая завершится с успешным кодом возврата

Выполняя же команды через ; вторая запустится независимо от кода выхода первой команды.

> Есть ли смысл использовать в bash &&, если применить set -e?

Смысла есть, т.к set -e устанавливает параметр оболочки с которым выполнение будет завершаться при возвращении одной из команд не нулевого значения, но задается для каждой оболочки отдельно, я считаю это менее удобно

8. > Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

из опций
-e оболочка завершает работу если одна из команд завершает свою работу с ненулевым значений

-u незаданные параметры, отличные от специальных будут трактоваться как ошибка при выполнения расширения параметров

-x будет печататься трассировка простых команд, команд for,case,select

-o установка параметра с полным именем

-pipefail возвращает успех если в конвейере ни одна команда не завершилась не удачно 

Потому что данные параметры защищают от ошибок в выполнении сценария о которых мы можем не узнать, т.к сценарий завершился успешно.

9. > Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

```
root@vagrant:/home/vagrant/bcc/build# ps -o stat
STAT
T
T
S
S
S
R+
```
Наиболее частый статус -T - остановлен заданием сигнала управления
-t - остановлен отладчиком во время трассировки 

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
