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

# Домашнее задание к занятию "3.5. Файловые системы"

> 2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Нет не могут, потому что жесткие ссылки имеют те же разрешения что и у исходного файла, разрешения на ссылку изменяться при изменении разрешений файла.

> 4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
```
vagrant@vagrant:/dev$ sudo fdisk /dev/sdb

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-5242879, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2):
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879):

Created a new partition 2 of type 'Linux' and of size 511 MiB.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

vagrant@vagrant:/dev$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
└─sdb2                 8:18   0  511M  0 part
sdc                    8:32   0  2.5G  0 disk
```

> 5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.

```
vagrant@vagrant:/dev$ sudo sfdisk -d /dev/sdb | sudo sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xb1064964.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xb1064964

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
vagrant@vagrant:/dev$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm  /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm  [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
└─sdb2                 8:18   0  511M  0 part
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
└─sdc2                 8:34   0  511M  0 part
```

> 6. Соберите mdadm RAID1 на паре разделов 2 Гб.

```
vagrant@vagrant:/dev$ sudo mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{b,c}1
mdadm: partition table exists on /dev/sdb1
mdadm: partition table exists on /dev/sdb1 but will be lost or
       meaningless after creating array
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
vagrant@vagrant:/dev$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
```

>7. Соберите mdadm RAID0 на второй паре маленьких разделов.

```
vagrant@vagrant:/dev$ sudo mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{b,c}2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
vagrant@vagrant:/dev$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
  ```

>8. Создайте 2 независимых PV на получившихся md-устройствах.
```
vagrant@vagrant:/dev$ sudo pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
vagrant@vagrant:/dev$ sudo pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.

vagrant@vagrant:/dev
  PV /dev/sda5   VG vgvagrant       lvm2 [<63.50 GiB / 0    free]
  PV /dev/md0                       lvm2 [<2.00 GiB]
  PV /dev/md1                       lvm2 [1018.00 MiB]
  Total: 3 [<66.49 GiB] / in use: 1 [<63.50 GiB] / in no VG: 2 [2.99 GiB]
```
> 9. Создайте общую volume-group на этих двух PV.

```
vagrant@vagrant:/dev$ sudo vgcreate vg1 /dev/md0 /dev/md1
  Volume group "vg1" successfully created
vagrant@vagrant:/dev$ sudo vgdisplay
  --- Volume group ---
  VG Name               vgvagrant
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  3
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <63.50 GiB
  PE Size               4.00 MiB
  Total PE              16255
  Alloc PE / Size       16255 / <63.50 GiB
  Free  PE / Size       0 / 0
  VG UUID               7BSgp8-ukNs-898j-wRdT-jDVA-TLU9-sSZ36F

  --- Volume group ---
  VG Name               vg1
  System ID
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               <2.99 GiB
  PE Size               4.00 MiB
  Total PE              765
  Alloc PE / Size       0 / 0
  Free  PE / Size       765 / <2.99 GiB
  VG UUID               n3bUCU-WES4-lE7g-e0HN-PyN5-l0bw-JDd7ud
```

> 10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

```

vagrant@vagrant:~$ sudo lvcreate -L 100M -n lv1 vg1 /dev/md1
  Logical volume "lv1" created.  
vagrant@vagrant:~$ sudo lvdisplay
  --- Logical volume ---
  LV Path                /dev/vgvagrant/root
  LV Name                root
  VG Name                vgvagrant
  LV UUID                8oG9Wg-njJx-buVu-ewPB-P2gy-TRC7-yLRu5Z
  LV Write Access        read/write
  LV Creation host, time vagrant, 2021-05-25 05:42:42 +0000
  LV Status              available
  # open                 1
  LV Size                <62.54 GiB
  Current LE             16010
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0

  --- Logical volume ---
  LV Path                /dev/vgvagrant/swap_1
  LV Name                swap_1
  VG Name                vgvagrant
  LV UUID                OXf1hc-6u1q-Fanf-X8xq-B45n-eZgs-65c8nD
  LV Write Access        read/write
  LV Creation host, time vagrant, 2021-05-25 05:42:42 +0000
  LV Status              available
  # open                 2
  LV Size                980.00 MiB
  Current LE             245
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/vg1/lv1
  LV Name                lv1
  VG Name                vg1
  LV UUID                9aKSeE-cdS5-fdya-nhjh-W1A1-adaZ-VS56ot
  LV Write Access        read/write
  LV Creation host, time vagrant, 2021-07-17 14:19:56 +0000
  LV Status              available
  # open                 0
  LV Size                100.00 MiB
  Current LE             25
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     4096
  Block device           253:2

```

> 11. Создайте mkfs.ext4 ФС на получившемся LV.

```
vagrant@vagrant:~$ sudo mkfs.ext4 /dev/vg1/lv1
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```

> 12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.

```
vagrant@vagrant:/$ mkdir /tmp/new
vagrant@vagrant:/$ sudo mount /dev/vg1/lv1 /tmp/new
```

> 13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

```
vagrant@vagrant:/tmp/new$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.
--2021-07-17 14:27:45--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 21060614 (20M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz.’

/tmp/new/test.gz.            100%[===========================================>]  20.08M  26.3MB/s    in 0.8s

2021-07-17 14:27:46 (26.3 MB/s) - ‘/tmp/new/test.gz.’ saved [21060614/21060614]

vagrant@vagrant:/tmp/new$ ls
lost+found  test.gz.

```
> 14. Прикрепите вывод lsblk.

```

vagrant@vagrant:/tmp/new$ lsblk
NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                    8:0    0   64G  0 disk
├─sda1                 8:1    0  512M  0 part  /boot/efi
├─sda2                 8:2    0    1K  0 part
└─sda5                 8:5    0 63.5G  0 part
  ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]
sdb                    8:16   0  2.5G  0 disk
├─sdb1                 8:17   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdb2                 8:18   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─vg1-lv1        253:2    0  100M  0 lvm   /tmp/new
sdc                    8:32   0  2.5G  0 disk
├─sdc1                 8:33   0    2G  0 part
│ └─md0                9:0    0    2G  0 raid1
└─sdc2                 8:34   0  511M  0 part
  └─md1                9:1    0 1018M  0 raid0
    └─vg1-lv1        253:2    0  100M  0 lvm   /tmp/new

```
> 15. Протестируйте целостность файла:

```
vagrant@vagrant:/tmp/new$ gzip -t /tmp/new/test.gz.
vagrant@vagrant:/tmp/new$ echo $?
0
``` 

> 16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

```
vagrant@vagrant:/dev/vg1$ sudo pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 56.00%
  /dev/md1: Moved: 100.00%
  ```

> 17. Сделайте --fail на устройство в вашем RAID1 md.

```
vagrant@vagrant:/dev/vg1$ sudo mdadm /dev/md0 --fail /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
``` 

> 18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.


```
vagrant@vagrant:/dev/vg1$ sudo dmesg | grep raid
[    5.612122] md/raid1:md127: active with 2 out of 2 mirrors
[    6.154679] raid6: sse2x4   gen() 11431 MB/s
[    6.202240] raid6: sse2x4   xor()  6692 MB/s
[    6.251094] raid6: sse2x2   gen()  9164 MB/s
[    6.298888] raid6: sse2x2   xor()  5803 MB/s
[    6.346686] raid6: sse2x1   gen()  7802 MB/s
[    6.394569] raid6: sse2x1   xor()  5827 MB/s
[    6.394570] raid6: using algorithm sse2x4 gen() 11431 MB/s
[    6.394571] raid6: .... xor() 6692 MB/s, rmw enabled
[    6.394572] raid6: using ssse3x2 recovery algorithm
[11754.407287] md/raid1:md0: not clean -- starting background reconstruction
[11754.407289] md/raid1:md0: active with 2 out of 2 mirrors
[29558.263766] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```
> 19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

```
vagrant@vagrant:/dev/vg1$ echo $?
0
vagrant@vagrant:/dev/vg1$
```

# Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

> 1. Работа c HTTP через телнет.
> * Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
> * отправьте HTTP запрос
```
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.193.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0 Host: stackoverflow.com

HTTP/1.1 400 Bad Request
Connection: close
Content-Length: 0

Connection closed by foreign host.
```

Ошибка 400 означает что сервер не смог обработать запрос, из-за неверного синтаксиса.

> 2. Повторите задание 1 в браузере, используя консоль разработчика F12.

```
Request URL: https://stackoverflow.com/questions
Request Method: GET
Status Code: 200 
Remote Address: 151.101.129.69:443
```
Дольше всего обрабатывается запрос Request URL: https://graph.facebook.com/1996454190623373/picture?type=large , т.к происходит перенаправление
![network](/images/network.png)

> 3. Какой IP адрес у вас в интернете?

188.234.213.175

> 4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

Принадлежит проайдеру "Дом.ру", автономная система AS51604

> 5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute

```
vagrant@vagrant:~$ traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.10.10.1 [*]  0.731 ms  0.601 ms  0.504 ms
 2  * * *
 3  109.195.104.18 [AS51604]  3.671 ms  3.586 ms  3.501 ms
 4  188.234.131.145 [AS9049]  20.206 ms  20.082 ms  19.992 ms
 5  188.234.131.144 [AS9049]  21.355 ms  21.269 ms  21.178 ms
 6  10.23.140.190 [*]  21.090 ms 10.252.231.62 [*]  21.238 ms 10.23.173.62 [*]  21.144 ms
 7  108.170.250.129 [AS15169]  21.442 ms 64.233.174.218 [AS15169]  20.973 ms 108.170.227.82 [AS15169]  20.388 ms
 8  108.170.250.66 [AS15169]  20.803 ms 108.170.250.51 [AS15169]  30.034 ms 108.170.250.146 [AS15169]  20.491 ms
 9  172.253.66.116 [AS15169]  33.591 ms 142.251.49.158 [AS15169]  32.106 ms *
10  72.14.238.168 [AS15169]  29.870 ms 209.85.254.6 [AS15169]  31.334 ms 172.253.65.159 [AS15169]  30.805 ms
11  142.250.56.219 [AS15169]  34.899 ms 172.253.64.113 [AS15169]  34.812 ms 142.250.56.129 [AS15169]  32.324 ms
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  8.8.8.8 [AS15169]  30.256 ms  31.112 ms  32.694 ms
```
>6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?

vagrant@vagrant:~$ traceroute -An 8.8.8.8

```
vagrant (10.10.10.107)                                                                                                                                                       2021-07-17T15:47:26+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                                                                                                             Packets               Pings
 Host                                                                                                                                                      Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. AS???    10.10.10.1                                                                                                                                     0.0%    22    1.2   1.0   0.8   2.4   0.4
 2. AS51604  109.195.110.124                                                                                                                                0.0%    22    1.4   1.6   1.4   2.7   0.3
 3. AS51604  109.195.104.18                                                                                                                                 0.0%    22    1.4   2.6   1.4  14.8   2.8
 4. AS9049   188.234.131.145                                                                                                                                0.0%    22   20.4  21.1  20.3  25.6   1.3
 5. AS9049   188.234.131.144                                                                                                                                0.0%    21   21.4  21.5  21.0  22.1   0.2
 6. AS15169  142.250.239.55                                                                                                                                 0.0%    21   20.9  21.3  20.8  25.4   1.1
 7. AS15169  108.170.250.99                                                                                                                                 0.0%    21   21.5  21.7  21.4  22.8   0.3
 8. AS15169  172.253.66.116                                                                                                                                 0.0%    21   33.8  34.0  33.6  34.7   0.3
 9. AS15169  209.85.254.6                                                                                                                                   0.0%    21   33.7  33.9  33.6  34.6   0.3
10. AS15169  74.125.253.147                                                                                                                                 0.0%    21   34.8  34.5  33.8  39.5   1.2
11. (waiting for reply)
12. (waiting for reply)
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. (waiting for reply)
19. (waiting for reply)
20. AS15169  8.8.8.8                                                                                                                                        0.0%    21   33.2  33.1  33.0  33.4   0.1

```
максимальная задержка на 10ом участке AS15169  74.125.253.147

> 7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig


```
vagrant@vagrant:~$ dig +trace dns.google
```
Авторизованные ДНС сервера
```
dns.google.             10800   IN      NS      ns2.zdns.google.
dns.google.             10800   IN      NS      ns1.zdns.google.
dns.google.             10800   IN      NS      ns3.zdns.google.
dns.google.             10800   IN      NS      ns4.zdns.google.
```
Записи типа А
```
dns.google.             900     IN      A       8.8.8.8
dns.google.             900     IN      A       8.8.4.4
```
> 8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig

```
vagrant@vagrant:~$ dig -x 8.8.8.8

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 19271
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   5978    IN      PTR     dns.google.

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Sat Jul 17 16:03:18 UTC 2021
;; MSG SIZE  rcvd: 73

vagrant@vagrant:~$ dig -x 8.8.4.4

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 24924
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.   7006    IN      PTR     dns.google.

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Sat Jul 17 16:03:22 UTC 2021
;; MSG SIZE  rcvd: 73
```

Доменное имя dns.google.

# Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"

> 1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

Для Windows команда
```
ipconfig /all
```
Для Linux 
```
ip a
ifconfig
nestat -i
```

> 2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

Протокол LLDP, пакет lldpd, команда lldpctl

> 3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Технология VLAN, для создания VLAN и работы с VLAN исспользуется пакет vlan, network и ip. 

Примеры команд 
```
vconfig add eth0 5
```
```
ip link add link eth0 name eth0.10 type vlan id 10
```
Добавление vlan через конфигурацию interfaces 
```
sudo nano /etc/network/interfaces

auto eth0.100
iface eth0.100 inet static
address 192.168.1.200
netmask 255.255.255.0
vlan-raw-device eth0

systemctl restart network
```
> 4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

Типы Mode-0(balance-rr), Mode-1(active-backup), Mode-2(balance-xor), Mode-3(broadcast), Mode-4(802.3ad), Mode-5(balance-tlb), Mode-6(balance-alb).

В первом типе балансировка происходит методом отправки пакетов по кругу,Если выходит из строя один из интерфейсов, пакеты отправляются на остальные оставшиеся.

Во втором режиме передача пакетов распределяется между объединенными интерфейсами по формуле ((MAC-адрес источника) XOR (MAC-адрес получателя)) % число интерфейсов.

В пятом типе входящий трафик получается только активным интерфейсом, исходящий - распределяется в зависимости от текущей загрузки каждого интерфейса.

Шестой тип обеспечивает балансировку нагрузки как исходящего (TLB, transmit load balancing), так и входящего трафика (для IPv4 через ARP).

Пример конфига:

```
$ sudo nano /etc/network/interfaces
# The primary network interface
auto bond0
iface bond0 inet static
    address 192.168.1.150
    netmask 255.255.255.0    
    gateway 192.168.1.1
    dns-nameservers 192.168.1.1 8.8.8.8
    dns-search domain.local
        slaves eth0 eth1
        bond_mode 0
        bond-miimon 100
        bond_downdelay 200
        bound_updelay 200
```

> 5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

в маске /29 8 адресов, из них один адрес подсети и один широковещательный

32 /29 подсетей можно получить из сети с маской /24.

Примеры:

10.10.10.0 - 10.10.10.6

10.10.10.9 - 10.10.10.15

10.10.10.18 - 10.10.10.24

> 6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

Можно взять подсесть 100.64.0.0/10

> 7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Проверка таблицы

windows
```
arp -a  windows
```

linux

```
ip neigh    linux
```
очистка ARP кеша

windows
```
netsh interface ip delete arpcache
```

linux

```
sudo ip neigh flush all  
```
Удаление из таблицы одного адреса

windows

```
arp -d 192.168.100.25  
```

linux

```
sudo ip neigh flush 10.10.10.105 
```
# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

> 1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

```
vagrant@vagrant:~$ telnet route-views.routeviews.org
Trying 128.223.51.103...
Connected to route-views.routeviews.org.
Escape character is '^]'.
C
**********************************************************************

                    RouteViews BGP Route Viewer
                    route-views.routeviews.org

 route views data is archived on http://archive.routeviews.org

 This hardware is part of a grant by the NSF.
 Please contact help@routeviews.org if you have questions, or
 if you wish to contribute your view.

 This router has views of full routing tables from several ASes.
 The list of peers is located at http://www.routeviews.org/peers
 in route-views.oregon-ix.net.txt

 NOTE: The hardware was upgraded in August 2014.  If you are seeing
 the error message, "no default Kerberos realm", you may want to
 in Mac OS X add "default unset autologin" to your ~/.telnetrc

 To login, use the username "rviews".

 **********************************************************************


User Access Verification

Username: rviews
route-views>show ip route 188.234.213.175
Routing entry for 188.234.192.0/18
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 7w0d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 7w0d ago
      Route metric is 0, traffic share count is 1
      AS Hops 6
      Route tag 6939
      MPLS label: none
route-views>show bgp 188.234.213.175
BGP routing table entry for 188.234.192.0/18, version 56063966
Paths: (25 available, best #23, table default)
  Not advertised to any peer
  Refresh Epoch 1
  20912 3257 9002 9049 51604 51604 51604 51604
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8052 3257:50001 3257:54900 3257:54901 20912:65004 65535:65284
      path 7FE16E0391C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 9002 9002 9002 9002 9002 9049 51604 51604 51604 51604
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE0EC3E6CB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 9049 51604 51604 51604 51604
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin incomplete, metric 0, localpref 100, valid, external
      path 7FE129D5C328 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 9002 9049 51604 51604 51604 51604
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE0CE0405B0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 9002 9002 9002 9002 9002 9049 51604 51604 51604 51604
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
      path 7FE0A40E19C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 9002 9002 9002 9002 9002 9049 51604 51604 51604 51604
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      path 7FE12B9B1570 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 174 174 1299 9049 9049 51604 51604 51604 51604
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin incomplete, localpref 100, valid, external
      Community: 174:21000 174:22013 53767:5000
      path 7FE0A54C5400 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 1299 9049 9049 51604 51604 51604 51604
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin incomplete, localpref 100, valid, external
      path 7FE090D67240 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 6453 9002 9049 51604 51604 51604 51604
    154.11.12.212 from 154.11.12.212 (96.1.209.43)

route-views>Connection closed by foreign host.
```

> 2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

```
vagrant@vagrant:~$ sudo ip link add dummy0 type dummy
vagrant@vagrant:~$ sudo ip addr add 1.1.1.1/24 dev dummy0
vagrant@vagrant:~$ sudo ip link set dummy0 up
vagrant@vagrant:~$ ifconfig -a
dummy0: flags=195<UP,BROADCAST,RUNNING,NOARP>  mtu 1500
        inet 1.1.1.1  netmask 255.255.255.0  broadcast 0.0.0.0
        inet6 fe80::88a5:18ff:fe1f:1baa  prefixlen 64  scopeid 0x20<link>
        ether 8a:a5:18:1f:1b:aa  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2  bytes 140 (140.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.10.10.107  netmask 255.255.255.0  broadcast 10.10.10.255
        inet6 fe80::a00:27ff:fee3:90c5  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:e3:90:c5  txqueuelen 1000  (Ethernet)
        RX packets 7802  bytes 1713449 (1.7 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3206  bytes 327661 (327.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 85  bytes 7804 (7.8 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 85  bytes 7804 (7.8 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


vagrant@vagrant:~$ sudo  ip route add 172.16.10.0/24 dev dummy0
vagrant@vagrant:~$ sudo ip route add 192.168.0.0/24 via 1.1.1.1
vagrant@vagrant:~$ ip -br route
default via 10.10.10.1 dev eth0 proto dhcp src 10.10.10.107 metric 100
1.1.1.0/24 dev dummy0 proto kernel scope link src 1.1.1.1
10.10.10.0/24 dev eth0 proto kernel scope link src 10.10.10.107
10.10.10.1 dev eth0 proto dhcp scope link src 10.10.10.107 metric 100
172.16.10.0/24 dev dummy0 scope link
192.168.0.0/24 via 1.1.1.1 dev dummy0

```

> 3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
```
vagrant@vagrant:~$ sudo netstat -tlpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/init
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      720/systemd-resolve
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      798/sshd: /usr/sbin
tcp6       0      0 :::111                  :::*                    LISTEN      1/init
tcp6       0      0 :::22                   :::*                    LISTEN      798/sshd: /usr/sbin

22 - порт ssh, сетевой протокол прикладного уровня, позволяющий производить удалённое управление операционной системой и туннелирование TCP-соединений

53- порт systemd-resolve, выполняющая разрешение сетевых имён для локальных приложений посредством D-Bus

111 - порт init, система удаленного вызова процедур

```

> 4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

```
vagrant@vagrant:~$ sudo netstat -ulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
udp        0      0 127.0.0.53:53           0.0.0.0:*                           720/systemd-resolve
udp        0      0 10.10.10.107:68         0.0.0.0:*                           448/systemd-network
udp        0      0 0.0.0.0:111             0.0.0.0:*                           1/init
udp6       0      0 :::111                  :::*                                1/init
udp6       0      0 fe80::a00:27ff:fee3:546 :::*                                448/systemd-network

68 - порт systemd-networkd, системный демон для управления сетевыми настройками.

```

> 5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

![diagram](/images/diagram.png)

> 6. Установите Nginx, настройте в режиме балансировщика TCP или UDP.

```
vagrant@vagrant:~$ sudo apt-get install nginx
vagrant@vagrant:~$ sudo sudo systemctl enable nginx
vagrant@vagrant:~$ sudo sudo systemctl start nginx
vagrant@vagrant:~$ sudo sudo systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-07-21 13:29:28 UTC; 19s ago
       Docs: man:nginx(8)
   Main PID: 36141 (nginx)
      Tasks: 3 (limit: 1072)
     Memory: 5.7M
     CGroup: /system.slice/nginx.service
             ├─36141 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─36142 nginx: worker process
             └─36143 nginx: worker process

Jul 21 13:29:28 vagrant systemd[1]: Starting A high performance web server and a reverse proxy server...
Jul 21 13:29:28 vagrant systemd[1]: Started A high performance web server and a reverse proxy server.
