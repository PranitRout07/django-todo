pipeline {
    agent any

    stages {
        stage('Fetch code') {
            steps {
                git branch: 'develop', url: 'https://github.com/PranitRout07/django-todo.git'
            }
        }
    
        stage('scan with trivy') {
            steps {
            
                bat "docker run --rm -v D:/trivy-report/:/root/.cache/ aquasec/trivy:0.18.3 fs . > reports"
            }
        }
        stage('Code Analysis') {
            environment {
                scannerHome = tool 'sonar4.7'
            }
            steps {
               withSonarQubeEnv('sonar') {
                   bat '%scannerHome%\\bin\\sonar-scanner -Dsonar.projectKey=3- ' +
                    '-Dsonar.projectName=todo-app ' +
                    '-Dsonar.projectVersion=1.0 ' +
                    '-Dsonar.sources=. '
              }
            }
        }
        stage ('Build docker image'){
            steps {
                bat "docker build -t todo-app ."
            }
        }
        stage('Push image to dockerhub'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerPass', usernameVariable: 'dockerUser')]) {
                   bat "docker login -u ${env.dockerUser} -p ${env.dockerPass}"
                   bat "docker tag todo-app ${env.dockerUser}/todo-app:latest"
                   bat "docker push ${env.dockerUser}/todo-app:latest "
            }
        }
        }
        stage('Deploy'){
            steps{
                bat "docker run -d -p 8000:8000 pranit007/todo-app:latest "
            }
        }
    }
}
