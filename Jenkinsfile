pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch:'main', url: 'https://github.com/DuVanSang/QLTV.git'
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
                bat '''
                    cd backend\\target
                    taskkill /F /IM java.exe || echo Không có tiến trình java đang chạy
                    start /B java -jar Lib-mng.jar
                '''
            }
        }
    }
}
