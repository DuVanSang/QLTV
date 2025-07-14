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
                bat 'mvn -f backend\\pom.xml clean package'
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                    REM Tìm PID tiến trình chạy jar bằng WMIC và kill nó nếu đang chạy
                    for /f "tokens=2 delims==;" %%i in ('wmic process where "CommandLine like '%%library-management-backend%%'" get ProcessId /format:value ^| find "="') do (
                        echo Killing existing backend process with PID=%%i
                        taskkill /PID %%i /F
                    )

                    REM Chạy lại ứng dụng
                    start /B java -jar backend\\target\\library-management-backend-0.0.1-SNAPSHOT.jar --server.port=9999
                '''
            }
        }
    }
}

