# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

> 1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

![bitwarden](/images/bitwarden.png)

> 2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

![auth](/images/auth.png)

> 3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

```
vagrant@vagrant:~$ sudo apt update

vagrant@vagrant:~$ sudo apt install apache2

vagrant@vagrant:~$ sudo systemctl status apache2
● apache2.service - The Apache HTTP Server
Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
Active: active (running) since Mon 2021-07-26 13:23:29 UTC; 27s ago
Docs: https://httpd.apache.org/docs/2.4/
Main PID: 1721 (apache2)
Tasks: 55 (limit: 1071)
Memory: 5.6M
CGroup: /system.slice/apache2.service
├─1721 /usr/sbin/apache2 -k start
├─1722 /usr/sbin/apache2 -k start
└─1723 /usr/sbin/apache2 -k start

Jul 26 13:23:29 vagrant systemd[1]: Starting The Apache HTTP Server...
Jul 26 13:23:29 vagrant systemd[1]: Started The Apache HTTP Server.

vagrant@vagrant:~$ sudo a2enmod ssl
Considering dependency setenvif for ssl:
Module setenvif already enabled
Considering dependency mime for ssl:
Module mime already enabled
Considering dependency socache_shmcb for ssl:
Enabling module socache_shmcb.
Enabling module ssl.
See /usr/share/doc/apache2/README.Debian.gz on how to configure SSL and create self-signed certificates.
To activate the new configuration, you need to run:
systemctl restart apache2

vagrant@vagrant:~$ sudo systemctl restart apache2

vagrant@vagrant:~$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \-keyout /etc/ssl/private/apache-selfsigned.key \-out /etc/ssl/certs/apache-selfsigned.crt \-subj "/C=RU/ST=Moscow/L=Moscow/O=Company Name/OU=Org/CN=www.example.com"
Generating a RSA private key
............................+++++
....................+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----

vagrant@vagrant:~$ sudo nano /etc/apache2/sites-available/10.10.10.108.conf

<VirtualHost *:443>   ServerName 10.10.10.108   DocumentRoot /var/www/your_domain_or_ip   SSLEngine on   SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt   SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key</VirtualHost>

vagrant@vagrant:~$ sudo mkdir /var/www/10.10.10.108

vagrant@vagrant:~$ sudo nano /var/www/10.10.10.108/index.html

<h1>it worked!</h1>

vagrant@vagrant:~$ sudo a2ensite 10.10.10.108.conf
Enabling site 10.10.10.108.
To activate the new configuration, you need to run:
systemctl reload apache2

vagrant@vagrant:~$ sudo apache2ctl configtest
Syntax OK

vagrant@vagrant:~$ sudo systemctl reload apache2
```

![apache2](/images/apache2.png)

> 4. Проверьте на TLS уязвимости произвольный сайт в интернете.

```
vagrant@vagrant:~/testssl.sh$ ./testssl.sh -e --fast --parallel https://netology.ru/

###########################################################
testssl.sh       3.1dev from https://testssl.sh/dev/
(18dfa26 2021-07-25 16:34:58 -- )

This program is free software. Distribution and
modification under GPLv2 permitted.
USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

Please file bugs @ https://testssl.sh/bugs/

###########################################################

Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
on vagrant:./bin/openssl.Linux.x86_64
(built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


Testing all IPv4 addresses (port 443): 104.22.49.171 172.67.43.83 104.22.48.171
------------------------------------------------------------------------------------------------------------------
Start 2021-07-26 13:42:43        -->> 104.22.49.171:443 (netology.ru) <<--

Further IP addresses:   172.67.43.83 104.22.48.171 2606:4700:10::ac43:2b53 2606:4700:10::6816:30ab 2606:4700:10::6816:31ab 
rDNS (104.22.49.171):   --
Service detected:       HTTP



Testing all 183 locally available ciphers against the server, ordered by encryption strength 


Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
xcc14   ECDHE-ECDSA-CHACHA20-POLY1305-OLD ECDH 256   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256_OLD  
xcc13   ECDHE-RSA-CHACHA20-POLY1305-OLD   ECDH 256   ChaCha20    256      TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256_OLD    
xc030   ECDHE-RSA-AES256-GCM-SHA384       ECDH 256   AESGCM      256      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384              
xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
xc028   ECDHE-RSA-AES256-SHA384           ECDH 256   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384              
xc024   ECDHE-ECDSA-AES256-SHA384         ECDH 256   AES         256      TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384            
xc014   ECDHE-RSA-AES256-SHA              ECDH 256   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA                 
xc00a   ECDHE-ECDSA-AES256-SHA            ECDH 256   AES         256      TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA               
x9d     AES256-GCM-SHA384                 RSA        AESGCM      256      TLS_RSA_WITH_AES_256_GCM_SHA384                    
x3d     AES256-SHA256                     RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA256                    
x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA                       
xc02f   ECDHE-RSA-AES128-GCM-SHA256       ECDH 256   AESGCM      128      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256              
xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            
xc027   ECDHE-RSA-AES128-SHA256           ECDH 256   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256              
xc023   ECDHE-ECDSA-AES128-SHA256         ECDH 256   AES         128      TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256            
xc013   ECDHE-RSA-AES128-SHA              ECDH 256   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA                 
xc009   ECDHE-ECDSA-AES128-SHA            ECDH 256   AES         128      TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA               
x9c     AES128-GCM-SHA256                 RSA        AESGCM      128      TLS_RSA_WITH_AES_128_GCM_SHA256                    
x3c     AES128-SHA256                     RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA256                    
x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA                       
x0a     DES-CBC3-SHA                      RSA        3DES        168      TLS_RSA_WITH_3DES_EDE_CBC_SHA                      


Done 2021-07-26 13:42:49 [  11s] -->> 104.22.49.171:443 (netology.ru) <<--

------------------------------------------------------------------------------------------------------------------
Start 2021-07-26 13:42:49        -->> 172.67.43.83:443 (netology.ru) <<--

Further IP addresses:   104.22.49.171 104.22.48.171 2606:4700:10::ac43:2b53 2606:4700:10::6816:30ab 2606:4700:10::6816:31ab 
rDNS (172.67.43.83):    --
Service detected:       HTTP



Testing all 183 locally available ciphers against the server, ordered by encryption strength 


Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
xcc14   ECDHE-ECDSA-CHACHA20-POLY1305-OLD ECDH 256   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256_OLD  
xcc13   ECDHE-RSA-CHACHA20-POLY1305-OLD   ECDH 256   ChaCha20    256      TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256_OLD    
xc030   ECDHE-RSA-AES256-GCM-SHA384       ECDH 256   AESGCM      256      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384              
xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384            
xc028   ECDHE-RSA-AES256-SHA384           ECDH 256   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384              
xc024   ECDHE-ECDSA-AES256-SHA384         ECDH 256   AES         256      TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384            
xc014   ECDHE-RSA-AES256-SHA              ECDH 256   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA                 
xc00a   ECDHE-ECDSA-AES256-SHA            ECDH 256   AES         256      TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA               
x9d     AES256-GCM-SHA384                 RSA        AESGCM      256      TLS_RSA_WITH_AES_256_GCM_SHA384                    
x3d     AES256-SHA256                     RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA256                    
x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA                       
xc02f   ECDHE-RSA-AES128-GCM-SHA256       ECDH 256   AESGCM      128      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256              
xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256            
xc027   ECDHE-RSA-AES128-SHA256           ECDH 256   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256              
xc023   ECDHE-ECDSA-AES128-SHA256         ECDH 256   AES         128      TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256            
xc013   ECDHE-RSA-AES128-SHA              ECDH 256   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA                 
xc009   ECDHE-ECDSA-AES128-SHA            ECDH 256   AES         128      TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA               
x9c     AES128-GCM-SHA256                 RSA        AESGCM      128      TLS_RSA_WITH_AES_128_GCM_SHA256                    
x3c     AES128-SHA256                     RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA256                    
x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA                       
x0a     DES-CBC3-SHA                      RSA        3DES        168      TLS_RSA_WITH_3DES_EDE_CBC_SHA                      


Done 2021-07-26 13:42:55 [  17s] -->> 172.67.43.83:443 (netology.ru) <<--

------------------------------------------------------------------------------------------------------------------
Start 2021-07-26 13:42:55        -->> 104.22.48.171:443 (netology.ru) <<--

Further IP addresses:   104.22.49.171 172.67.43.83 2606:4700:10::ac43:2b53 2606:4700:10::6816:30ab 2606:4700:10::6816:31ab 
rDNS (104.22.48.171):   --
Service detected:       HTTP



Testing all 183 locally available ciphers against the server, ordered by encryption strength


Hexcode  Cipher Suite Name (OpenSSL)       KeyExch.   Encryption  Bits     Cipher Suite Name (IANA/RFC)
-----------------------------------------------------------------------------------------------------------------------------
xcc14   ECDHE-ECDSA-CHACHA20-POLY1305-OLD ECDH 256   ChaCha20    256      TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256_OLD
xcc13   ECDHE-RSA-CHACHA20-POLY1305-OLD   ECDH 256   ChaCha20    256      TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256_OLD
xc030   ECDHE-RSA-AES256-GCM-SHA384       ECDH 256   AESGCM      256      TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
xc02c   ECDHE-ECDSA-AES256-GCM-SHA384     ECDH 256   AESGCM      256      TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
xc028   ECDHE-RSA-AES256-SHA384           ECDH 256   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
xc024   ECDHE-ECDSA-AES256-SHA384         ECDH 256   AES         256      TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
xc014   ECDHE-RSA-AES256-SHA              ECDH 256   AES         256      TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
xc00a   ECDHE-ECDSA-AES256-SHA            ECDH 256   AES         256      TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
x9d     AES256-GCM-SHA384                 RSA        AESGCM      256      TLS_RSA_WITH_AES_256_GCM_SHA384
x3d     AES256-SHA256                     RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA256
x35     AES256-SHA                        RSA        AES         256      TLS_RSA_WITH_AES_256_CBC_SHA
xc02f   ECDHE-RSA-AES128-GCM-SHA256       ECDH 256   AESGCM      128      TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
xc02b   ECDHE-ECDSA-AES128-GCM-SHA256     ECDH 256   AESGCM      128      TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
xc027   ECDHE-RSA-AES128-SHA256           ECDH 256   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
xc023   ECDHE-ECDSA-AES128-SHA256         ECDH 256   AES         128      TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
xc013   ECDHE-RSA-AES128-SHA              ECDH 256   AES         128      TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
xc009   ECDHE-ECDSA-AES128-SHA            ECDH 256   AES         128      TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
x9c     AES128-GCM-SHA256                 RSA        AESGCM      128      TLS_RSA_WITH_AES_128_GCM_SHA256
x3c     AES128-SHA256                     RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA256
x2f     AES128-SHA                        RSA        AES         128      TLS_RSA_WITH_AES_128_CBC_SHA
x0a     DES-CBC3-SHA                      RSA        3DES        168      TLS_RSA_WITH_3DES_EDE_CBC_SHA


Done 2021-07-26 13:43:01 [  23s] -->> 104.22.48.171:443 (netology.ru) <<--

------------------------------------------------------------------------------------------------------------------
Done testing now all IP addresses (on port 443): 104.22.49.171 172.67.43.83 104.22.48.171

```

> 5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

```
vagrant@vagrant:~/testssl.sh$ sudo apt install openssh-server
Reading package lists... Done
Building dependency tree
Reading state information... Done
openssh-server is already the newest version (1:8.2p1-4ubuntu0.2).
0 upgraded, 0 newly installed, 0 to remove and 17 not upgraded.
```
```
vagrant@vagrant:~/testssl.sh$ sudo systemctl status sshd.service
● ssh.service - OpenBSD Secure Shell server
Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
Active: active (running) since Mon 2021-07-26 13:21:52 UTC; 28min ago
Docs: man:sshd(8)
man:sshd_config(5)
Main PID: 822 (sshd)
Tasks: 1 (limit: 1071)
Memory: 5.8M
CGroup: /system.slice/ssh.service
└─822 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups

Jul 26 13:21:52 vagrant systemd[1]: Started OpenBSD Secure Shell server.
Jul 26 13:22:46 vagrant sshd[902]: Accepted password for vagrant from 10.10.10.105 port 37670 ssh2
Jul 26 13:22:46 vagrant sshd[902]: pam_unix(sshd:session): session opened for user vagrant by (uid=0)
Jul 26 13:49:24 vagrant sshd[18946]: Connection closed by authenticating user vagrant 10.10.10.105 port 37998 [preauth]
Jul 26 13:49:24 vagrant sshd[18948]: Connection closed by authenticating user vagrant 10.10.10.105 port 38000 [preauth]
Jul 26 13:49:27 vagrant sshd[18950]: Accepted password for vagrant from 10.10.10.105 port 38002 ssh2
```
```
❯ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/fleedstix/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/fleedstix/.ssh/id_rsa
Your public key has been saved in /home/fleedstix/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:uUwIi2C6MEDLmzEn9VXH+rJfmB+jTbsmOO4r+Jgg+bc fleedstix@wkpc
The key's randomart image is:
+---[RSA 3072]----+
| . .   .....     |
|o o . .   ..     |
|oB ...    .      |
|+.B. o . o       |
|+o. . . S .      |
|.o.    o o .o    |
|.o .  . o +o =   |
|  o .oo. + .*.+  |
|   ..Eo.+++oo=.  |
+----[SHA256]-----+
```
```
❯ ssh-copy-id vagrant@10.10.10.108
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/fleedstix/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
vagrant@10.10.10.108's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'vagrant@10.10.10.108'"
and check to make sure that only the key(s) you wanted were added.
```

```
ssh vagrant@10.10.10.108
Enter passphrase for key '/home/fleedstix/.ssh/id_rsa': 
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-77-generic x86_64)

* Documentation:  https://help.ubuntu.com
* Management:     https://landscape.canonical.com
* Support:        https://ubuntu.com/advantage

System information as of Mon 26 Jul 2021 01:49:48 PM UTC

System load:  0.07              Processes:             116
Usage of /:   2.5% of 61.31GB   Users logged in:       1
Memory usage: 18%               IPv4 address for eth0: 10.10.10.108
Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Mon Jul 26 13:22:46 2021 from 10.10.10.105
```

> 6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

```
mv ~/.ssh/id_rsa ~/.ssh/key

ssh -i ~/.ssh/key vagrant@10.10.10.108

nano ~/.ssh/config

Host vagrant  
    HostName 10.10.10.108  
    IdentityFile ~/.ssh/key  
    User vagrant
```
> 7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
```
vagrant@vagrant:~$ sudo tcpdump -w 01.pcap -i eth0 -c 100
```
![wireshark](/images/wireshark.png)

> 8.  Просканируйте хост scanme.nmap.org. Какие сервисы запущены?
```
sudo nmap -O scanme.nmap.org

ssh
http
msrpc
netbios-ssn
microsoft-ds
nping-echo
Elite
```
> 9. Установите и настройте фаервол ufw на web-сервер из задания 3. Откройте доступ снаружи только к портам 22,80,443
```
vagrant@vagrant:~$ sudo apt install ufw
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ufw is already the newest version (0.36-6).
0 upgraded, 0 newly installed, 0 to remove and 17 not upgraded.

vagrant@vagrant:~$ sudo ufw status verbose
Status: inactive
vagrant@vagrant:~$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup

vagrant@vagrant:/etc/ufw/applications.d$ sudo ufw allow 22/tcp
Rule added
Rule added (v6)
vagrant@vagrant:/etc/ufw/applications.d$ sudo ufw allow 80/tcp
\Rule added
Rule added (v6)
vagrant@vagrant:/etc/ufw/applications.d$ sudo ufw allow 443/tcp
Rule added
Rule added (v6)

vagrant@vagrant:/etc/ufw/applications.d$ sudo ufw status verbose
\Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22                         ALLOW IN    Anywhere
22/tcp                     ALLOW IN    Anywhere
80/tcp                     ALLOW IN    Anywhere
443/tcp                    ALLOW IN    Anywhere
22 (v6)                    ALLOW IN    Anywhere (v6)
22/tcp (v6)                ALLOW IN    Anywhere (v6)
80/tcp (v6)                ALLOW IN    Anywhere (v6)
443/tcp (v6)               ALLOW IN    Anywhere (v6)
