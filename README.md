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