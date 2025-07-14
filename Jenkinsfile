pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DuVanSang/QLTV.git'
            }
        }

        stage('Build') {
            steps {
                bat 'cd backend && mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                bat 'cd backend && mvn test'
            }
        }

        stage('Package') {
            steps {
                bat 'cd backend && mvn package'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Triển khai ứng dụng tại đây...'
            }
        }
    }
}
