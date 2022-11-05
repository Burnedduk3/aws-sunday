pipeline {
    agent any
    stages {
        stage('Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}