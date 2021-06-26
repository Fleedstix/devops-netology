
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
 ``` export HISTSIZE = ``` < число строк> , но в manual через man history нет информации об этой переменной: ![histsize](/images/histsize.png)                         
 
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