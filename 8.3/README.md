# Домашнее задание к занятию "08.03 Использование Yandex Cloud"

> Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

```yaml

---
- name: Install Elasticsearch # Название play
  hosts: elasticsearch # будет выполнятся на хостах elasticsearch (указано в playbook/inventory/prod/prod.yml)
  handlers: # данная задача будет выполнятся при вызове из других задач ключевым словом notify
    - name: restart Elasticsearch
      become: true # c вызывается через sudo
      service: # перезапуск службы elasticsearch
        name: elasticsearch
        state: restarted
  tasks: # перечень задач для данного play
    - name: "Download Elasticsearch's rpm"
      get_url: # скачиваем по ссылке
        url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-{{ elk_stack_version }}-x86_64.rpm"
        dest: "/tmp/elasticsearch-{{ elk_stack_version }}-x86_64.rpm" # в папку назначения
      register: download_elastic # регистрируем результат
      until: download_elastic is succeeded # Выполняется до успешного результата
    - name: Install Elasticsearch
      become: true
      yum: # используем пакетный менеджер пакета
        name: "/tmp/elasticsearch-{{ elk_stack_version }}-x86_64.rpm"
        state: present # установка
    - name: Configure Elasticsearch
      become: true
      template: # приводим конфигурацию к шаблону
        src: elasticsearch.yml.j2
        dest: /etc/elasticsearch/elasticsearch.yml
      notify: restart Elasticsearch # вызываем наш handler
###Далее выполняются все те же действия для других хостов и пакетов
- name: Install Kibana
  hosts: kibana
  handlers:
    - name: restart kibana
      become: true
      service:
        name: kibana
        state: restarted
  tasks:
    - name: "Download kibana's rpm"
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ elk_stack_version }}-x86_64.rpm"
        dest: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
      register: download_kibana
      until: download_kibana is succeeded
    - name: Install kibana
      become: true
      yum:
        name: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
        state: present
    - name: Configure kibana
      become: true
      template:
        src: kibana.yml.j2
        dest: /etc/kibana/kibana.yml
      notify: restart kibana

- name: Install filebeat
  hosts: filebeat
  handlers:
    - name: restart filebeat
      become: true
      service:
        name: filebeat
        state: restarted
  tasks:
    - name: "Download filebeat's rpm"
      get_url:
        url: "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-{{ filebeat_version }}-x86_64.rpm"
        dest: "/tmp/filebeat-{{ filebeat_version }}-x86_64.rpm"
      register: download_filebeat
      until: download_filebeat is succeeded
    - name: Install filebeat
      become: true
      yum:
        name: "/tmp/filebeat-{{ filebeat_version }}-x86_64.rpm"
        state: present
    - name: Configure filebeat
      become: true
      template:
        src: filebeat.yml.j2
        dest: /etc/filebeat/filebeat.yml
      notify: restart filebeat

```

> Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.

[Ссылка на плейбук](./playbook/site.yml)