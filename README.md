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