pipeline {
    agent any
    tools {
        maven 'Maven 3.9.10'
        jdk 'JDK 21'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/DuVanSang/QLTV1.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn package'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Triển khai ứng dụng tại đây...'
            }
        }
    }
}
