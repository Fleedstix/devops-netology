# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

> 1. Есть скрипт:
```
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```
> * Какое значение будет присвоено переменной c?
с не будет присовенно значение, т.к. интерпретатор не складывает числа со строками.

> * Как получить для переменной c значение 12?
c = str(a) + b
> * Как получить для переменной c значение 3?'
c = a + int(b)

> 2. Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```
```py
import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print('~/netology/sysadm-homeworks/' +prepare_result)
```
```
vagrant@vagrant:~$ python3 script.py
~/netology/sysadm-homeworks/01-intro-01/README.md
~/netology/sysadm-homeworks/01-intro-01/netology.yaml
~/netology/sysadm-homeworks/04-script-02-py/README.md
~/netology/sysadm-homeworks/04-script-03-yaml/README.md
~/netology/sysadm-homeworks/README.md
```
> 3. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

```py
import os
import sys

if __name__ == "__main__":
    if len(sys.argv) == 2:
        dir = sys.argv[1]
    else:
        dir = '~/netology/sysadm-homeworks/'

bash_command = ["cd " + dir, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(dir + prepare_result)
```
```
vagrant@vagrant:~$ python3 script.py /home/vagrant/hello/sysadm-homeworks/
/home/vagrant/hello/sysadm-homeworks/04-script-02-py/README.md
/home/vagrant/hello/sysadm-homeworks/README.md
```

> 4. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.

Ссылка на файл c кодом:
[test.py](test.py)
```py
import os
import socket

resultArr = []
fileArr = []
fileLinesArr = []
servers = ['drive.google.com', 'mail.google.com', 'google.com', 'ru.stackoverflow.com', 'instagram.com', 'vk.com',
           'youtube.com', 'amazon.com', 'yandex.ru', 'mail.yandex.ru']


for server in servers:
    ip = socket.gethostbyname(server)
    resultArr.append(server + ' ' + ip)

writeConsArr = resultArr.copy()

if os.path.exists('app.log') is True:
    fileLinesArr = [line.rstrip('\n') for line in open('app.log', "r")]

if bool(fileLinesArr) is True:
    for i in range(len(resultArr)):
        if resultArr[i] != fileLinesArr[i]:
            errorArr = resultArr[i].split(" ")
            errorArr.insert(0,'[ERROR]')
            errorArr.insert(2, 'IP mismatch:')
            errorArr.insert(3, fileLinesArr[i].split(" ")[1])
            error = ' '.join(errorArr)
            writeConsArr[i] = error

writeCons = '\n'.join(writeConsArr)

print(writeCons)
result = '\n'.join(resultArr)

with open('app.log', "w+") as file:
    file.write(result)

```
Пример вывода:
```
drive.google.com 108.177.14.194
[ERROR] mail.google.com IP mismatch: 64.233.165.17 64.233.165.18
google.com 173.194.221.100
ru.stackoverflow.com 151.101.1.69
[ERROR] instagram.com IP mismatch: 52.23.131.79 3.233.236.119
vk.com 87.240.190.78
[ERROR] youtube.com IP mismatch: 142.250.150.93 142.250.150.136
amazon.com 205.251.242.103
yandex.ru 5.255.255.60
mail.yandex.ru 77.88.21.37
```
