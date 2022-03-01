# Домашнее задание к занятию "09.04 Jenkins"

> ScriptedJenkinsfile


```Groovy
node("linux"){  
    stage("Git checkout"){
        git credentialsId: '5ac0095d-0185-431b-94da-09a0ad9b0e2c', url: 'git@github.com:Fleedstix/testansible.git'
    }
    stage("Prod check"){
        prod_run = input(message: 'prod job?', parameters: [booleanParam(defaultValue: false, name: 'prod_run')])
    }
    stage("Run playbook"){
        sh 'python3 -m pip install -r test-requirements.txt && ansible-galaxy install -r requirements.yml -p roles && mkdir -p ./molecule/default/files'
        if (prod_run){
            sh 'ansible-playbook site.yml -i inventory/prod.yml'
        }
        else{
            sh 'ansible-playbook site.yml -i inventory/prod.yml --check--diff'
        }
    }
}
```

> DeclarativePipeline

```Groovy
pipeline {
    agent {
        node {
            label "linux"
        }
    }
    stages {
        stage('Checkout'){
            steps{
                    dir('mnt-homeworks-ansible') {
                    git branch: 'main', url: 'https://github.com/Fleedstix/testansible.git'
                    }
                }
            }
        stage('Install requirements'){
            steps{
                dir('mnt-homeworks-ansible') {
                sh 'python3 -m pip install -r test-requirements.txt`'
                }
            }
        }
        stage('Mkdir'){
            steps{
                dir('mnt-homeworks-ansible') {
                sh 'mkdir -p ./molecule/default/files'
                }
            }
        }
        stage('Run molecule'){
            steps{
                dir('mnt-homeworks-ansible') {
                sh 'molecule test'
                }
            }
        }
    }
}
```