pipeline {
    agent any
    stages {
        stage('Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Deploy') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }
}