# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

> 1. Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
{ "info" : "Sample JSON output from our service\t",
    "elements" :[
        { "name" : "first",
        "type" : "server",
        "ip" : 7175 
        },
        { "name" : "second",
        "type" : "proxy",
        "ip : 71.78.22.43
        }
    ]
}
```
```
{ "info" : "Sample JSON output from our service\t",
    "elements" :[
        { "name" : "first",
        "type" : "server",
        "ip" : 7175 
        },
        { "name" : "second",
        "type" : "proxy",
        "ip" : "71.78.22.43"
        }
    ]
}
```

> 2. В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

Ссылка на файл c кодом:
[sr.py](sr.py)
```py
import os
import socket
import json
import yaml

resultArr = []
fileArr = []
fileLinesArr = []
location_data = {}
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

with open("app.log") as f:
    for line in f:
        line = line.split( )
        location_data[line[0]] = line[1]

with open('app.json', 'w') as f:
    json.dump(location_data, f)

with open('app.yaml', 'w') as f:
    yaml.dump(location_data, f)

```
Пример вывода:
app.log
```
drive.google.com 108.177.14.194
mail.google.com 64.233.165.17
google.com 173.194.221.138
ru.stackoverflow.com 151.101.65.69
instagram.com 54.210.186.221
vk.com 87.240.190.72
youtube.com 142.250.150.190
amazon.com 54.239.28.85
yandex.ru 77.88.55.70
mail.yandex.ru 77.88.21.37
```
app.json
```json
{"drive.google.com": "108.177.14.194", "mail.google.com": "64.233.165.17", "google.com": "173.194.221.138", "ru.stackoverflow.com": "151.101.65.69", "instagram.com": "54.210.186.221", "vk.com": "87.240.190.72", "youtube.com": "142.250.150.190", "amazon.com": "54.239.28.85", "yandex.ru": "77.88.55.70", "mail.yandex.ru": "77.88.21.37"}
```
app.yaml
```yaml
amazon.com: 54.239.28.85
drive.google.com: 108.177.14.194
google.com: 173.194.221.138
instagram.com: 54.210.186.221
mail.google.com: 64.233.165.17
mail.yandex.ru: 77.88.21.37
ru.stackoverflow.com: 151.101.65.69
vk.com: 87.240.190.72
yandex.ru: 77.88.55.70
youtube.com: 142.250.150.190
```
