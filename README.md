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


