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
