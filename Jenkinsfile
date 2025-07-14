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

                    REM --- Tìm và dừng ứng dụng cũ đang chạy ở port 9999 ---
                    for /f "tokens=5" %%a in ('netstat -ano ^| findstr :9999') do (
                        echo Killing PID %%a using port 9999
                        taskkill /F /PID %%a
                    )

                    REM --- Tìm file JAR và chạy ---
                    for /f %%i in ('dir /b *.jar') do (
                        echo Running new JAR: %%i
                        start /B java -jar %%i --server.port=9999
                        goto :end
                    )

                    :end
                '''
            }
        }
    }
}

