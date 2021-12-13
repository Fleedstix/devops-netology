# Домашнее задание к занятию "08.02 Работа с Playbook"

> Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

``` yaml
---
- name: Install Java # Название play
  hosts: all # будет выполнятся на всех хостах
  tasks: # перечисление заданий, которые вполнятся на хостах
    - name: Set facts for Java 11 vars # название задания
      set_fact: # позволяет задавать переменные, связанные с текущим хостом.
        java_home: "/opt/jdk/{{ java_jdk_version }}"
      tags: java Добавляем тег к этому заданию
    - name: Upload .tar.gz file containing binaries from local storage
      copy: # копируем файлы в точку назначения
        src: "{{ java_oracle_jdk_package }}"
        dest: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
      register: download_java_binaries # регистрируем результат
      until: download_java_binaries is succeeded # Выполняется до успешного результата
      tags: java
    - name: Ensure installation dir exists
      become: true
      file: # Создаем дирректорию 
        state: directory
        path: "{{ java_home }}"
      tags: java
    - name: Extract java in the installation directory
      become: true
      unarchive: # разпаковываем архив с джавой в указанную дирректорию 
        copy: false
        src: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
        dest: "{{ java_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ java_home }}/bin/java"
      tags:
        - java
    - name: Export environment variables
      become: true
      template: Приводим файл к виду указаннного шаблона
        src: jdk.sh.j2
        dest: /etc/profile.d/jdk.sh
      tags: java
- name: Install Elasticsearch
  hosts: elasticsearch # play будет отрабатывать на группе хостов elasticsearch 
  become: true
  tasks:
    - name: Upload tar.gz Elasticsearch from remote URL
      get_url: # скачиваем архив с эластиком
        url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        mode: 0755 # задаем права на скачанный файл
        timeout: 60
        force: true # игнорировать ошибки
        validate_certs: false # отключаем проверку сертификатов
      register: get_elastic
      until: get_elastic is succeeded
      tags: elastic
    - name: Create directrory for Elasticsearch
      file:
        state: directory
        path: "{{ elastic_home }}"
      tags: elastic
    - name: Extract Elasticsearch in the installation directory
      unarchive:
        copy: false
        src: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
        dest: "{{ elastic_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ elastic_home }}/bin/elasticsearch"
      tags:
        - elastic
    - name: Set environment Elastic
      template:
        src: templates/elk.sh.j2
        dest: /etc/profile.d/elk.sh
      tags: elastic
- name: Install kibana
  hosts: kibana
  become: true
  tasks:
    - name: download kibana
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_kibana
      until: get_kibana is succeeded
      tags: kibana
    - name: Create directrory for kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract kibana in the installation directory
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags:
        - kibana
    - name: Set environment kibana
      template:
        src: templates/kibana.sh.j2
        dest: /etc/profile.d/kibana.sh
      tags: kibana
```

> 10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.

[site.yaml](./site.yml)
