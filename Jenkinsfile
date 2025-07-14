// pipeline {
//     agent any

//     stages {
//         stage('Checkout') {
//             steps {
//                 git branch:'main', url: 'https://github.com/DuVanSang/QLTV.git'
//             }
//         }

//         stage('Build') {
//             steps {
//                 bat 'cd backend && mvn clean compile'
//             }
//         }

//         stage('Test') {
//             steps {
//                 bat 'cd backend && mvn test'
//             }
//         }

//         stage('Package') {
//             steps {
//                 bat 'cd backend && mvn package'
//             }
//         }

//        stage('Deploy') {
//             steps {
//                 bat '''
//                     cd backend\\target
//                     taskkill /F /IM java.exe || echo No java process found
//                     start /B java -jar library-management-backend-0.0.1-SNAPSHOT.jar --server.port=9999
//                 '''
//             }
//         }
//     }
// }

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/DuVanSang/QLTV.git'
            }
        }

        stage('Build & Package') {
            steps {
                bat 'cd backend && mvn clean package'
            }
        }

        stage('Stop Previous App on Port 9999') {
            steps {
                bat '''
                    for /f "tokens=5" %%a in ('netstat -aon ^| findstr :9999') do (
                        echo Found PID %%a on port 9999
                        taskkill /PID %%a /F
                    )
                '''
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                    cd backend
                    start /B java -jar target\\library-management-backend-0.0.1-SNAPSHOT.jar --server.port=9999
                '''
            }
        }
    }
}

