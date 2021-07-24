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

vagrant@vagrant:~$ sudo nano /etc/nginx/nginx.conf

user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
	# multi_accept on;
}

stream {
       upstream dns_backends {
              server 8.8.8.8:53;    
              server 8.8.4.4:53;
       }
       server {
              listen 53 udp;    
              proxy_pass dns_backends;    
              proxy_responses 1;  
       }
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	# server_tokens off;

	# server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;
	##
	# Logging Settings
	##
	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}

vagrant@vagrant:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

vagrant@vagrant:~$ sudo systemctl enable nginx
Synchronizing state of nginx.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable nginx
vagrant@vagrant:~$ sudo systemctl start nginx 
vagrant@vagrant:~$ sudo systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
Active: active (running) since Sat 2021-07-24 09:31:01 UTC; 27min ago
Docs: man:nginx(8)
Main PID: 13473 (nginx)
Tasks: 3 (limit: 1071)
Memory: 14.1M
CGroup: /system.slice/nginx.service
├─13473 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
├─13474 nginx: worker process
└─13475 nginx: worker process

Jul 24 09:31:01 vagrant systemd[1]: Starting A high performance web server and a reverse proxy server...
Jul 24 09:31:01 vagrant systemd[1]: Started A high performance web server and a reverse proxy server.

```

> 7.  Установите bird2, настройте динамический протокол маршрутизации RIP.
```
vagrant@vagrant:~$ sudo apt install bird2
vagrant@vagrant:~$ sudo systemctl enable bird
Synchronizing state of bird.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable bird
vagrant@vagrant:~$ sudo nano /etc/bird/bird.conf

log syslog all;
protocol device {
}

protocol direct {
	disabled;		# Disable by default
	ipv4;			# Connect to default IPv4 table
	ipv6;			# ... and to default IPv6 table
}

protocol kernel {
	ipv4 {			# Connect protocol to IPv4 table by channel

	      export all;	# Export to protocol. default is export none
	};
}

protocol kernel {
	ipv6 { export all; };
}
protocol static {
	ipv4;			# Again, IPv4 channel with default options
}


protocol rip {
        ipv4 {
                import all;
                export all;
        };
        interface "ens4";
        interface "ens5";
}


```
> 8. Установите Netbox, создайте несколько IP префиксов, используя curl проверьте работу API.

```
root@vagrant:/opt# git clone -b release https://github.com/netbox-community/netbox-docker.git
Cloning into 'netbox-docker'...
remote: Enumerating objects: 3196, done.
remote: Counting objects: 100% (330/330), done.
remote: Compressing objects: 100% (185/185), done.
remote: Total 3196 (delta 169), reused 269 (delta 143), pack-reused 2866
Receiving objects: 100% (3196/3196), 788.55 KiB | 3.47 MiB/s, done.
Resolving deltas: 100% (1829/1829), done.
root@vagrant:/opt# cd netbox-docker
root@vagrant:/opt/netbox-docker# tee docker-compose.override.yml <<EOF
> version: '3.4'
> services:
>   netbox:
>     ports:
>       - 8000:8080
> EOF
version: '3.4'
services:
netbox:
ports:
- 8000:8080
root@vagrant:/opt/netbox-docker# docker-compose pull
Pulling postgres      ... done
Pulling redis         ... done
Pulling netbox-worker ... done
Pulling redis-cache   ... done
Pulling netbox        ... done
root@vagrant:/opt/netbox-docker# docker-compose up
Creating network "netbox-docker_default" with the default driver
Creating volume "netbox-docker_netbox-media-files" with local driver
Creating volume "netbox-docker_netbox-postgres-data" with local driver
Creating volume "netbox-docker_netbox-redis-data" with local driver
Creating netbox-docker_redis-cache_1 ... done
Creating netbox-docker_redis_1       ... done
Creating netbox-docker_postgres_1    ... done
Creating netbox-docker_netbox-worker_1 ... done
Creating netbox-docker_netbox_1        ... done
Attaching to netbox-docker_redis-cache_1, netbox-docker_redis_1, netbox-docker_postgres_1, netbox-docker_netbox-worker_1, netbox-docker_netbox_1
```
```
❯ curl -X POST \
-H "Authorization: Token 0123456789abcdef0123456789abcdef01234567" \
-H "Content-Type: application/json" \
-H "Accept: application/json; indent=4" \
http://10.10.10.108:8000/api/ipam/prefixes/ \
--data '{
"prefix": "192.0.2.0/24",
"status": "active",
"description": "test Description"
}'
{
"id": 1,
"url": "http://10.10.10.108:8000/api/ipam/prefixes/1/",
"display": "192.0.2.0/24",
"family": {
"value": 4,
"label": "IPv4"
},
"prefix": "192.0.2.0/24",
"site": null,
"vrf": null,
"tenant": null,
"vlan": null,
"status": {
"value": "active",
"label": "Active"
},
"role": null,
"is_pool": false,
"description": "test Description",
"tags": [],
"custom_fields": {},
"created": "2021-07-24",
"last_updated": "2021-07-24T12:02:12.226662Z",
"children": 0,
"_depth": 0
}%

curl -X POST \
-H "Authorization: Token 0123456789abcdef0123456789abcdef01234567" \
-H "Content-Type: application/json" \
-H "Accept: application/json; indent=4" \
http://10.10.10.108:8000/api/ipam/prefixes/ \
--data '{
"prefix": "192.0.3.0/24",
"status": "active",
"description": "test Description"
}'
{
"id": 2,
"url": "http://10.10.10.108:8000/api/ipam/prefixes/2/",
"display": "192.0.3.0/24",
"family": {
"value": 4,
"label": "IPv4"
},
"prefix": "192.0.3.0/24",
"site": null,
"vrf": null,
"tenant": null,
"vlan": null,
"status": {
"value": "active",
"label": "Active"
},
"role": null,
"is_pool": false,
"description": "test Description",
"tags": [],
"custom_fields": {},
"created": "2021-07-24",
"last_updated": "2021-07-24T12:13:26.533129Z",
"children": 0,
"_depth": 0
}
```


![netbox](/images/netbox.png)

