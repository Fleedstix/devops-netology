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