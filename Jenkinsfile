pipeline {
    agent any
    // tools {
    //     maven 'Maven 3.9.10'
    //     jdk 'JDK 21'
    // }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/DuVanSang/QLTV.git'
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
