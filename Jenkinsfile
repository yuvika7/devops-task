pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                     url: 'https://github.com/yuvika7/devops-task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-app:latest .'
            }
        }

        stage('Package Helm Chart') {
            steps {
                sh 'cd app-chart && helm package .'
            }
        }

        stage('Deploy') {
            steps {
                 withCredentials([file(credentialsId: 'my-kubeconfig', variable: 'KUBECONFIG')]){
                sh 'helm upgrade --install devops-release app-chart'
            }
        }
     }

        stage('Verify') {
            steps {
           withCredentials([file(credentialsId: 'my-kubeconfig', variable: 'KUBECONFIG')]) {
                sh 'kubectl get pods'
                sh 'kubectl get svc'
                sh 'kubectl get ingress'
            }
          }
       }
    }
}
