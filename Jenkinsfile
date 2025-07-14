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
//                     start /B java -jar Lib-mng.jar --server.port=9999
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
                bat '''
                    REM  Không dùng taskkill toàn bộ java.exe!
                    cd backend
                    mvn clean package -DskipTests
                '''
            }
        }

        stage('Test') {
            steps {
                bat 'cd backend && mvn test'
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                    cd backend\\target
                    REM Chỉ kill tiến trình chạy backend app, không kill Jenkins
                    for /f "tokens=2" %%a in (
                        'tasklist /FI "IMAGENAME eq java.exe" /v ^| findstr "library-management-backend"'
                    ) do taskkill /PID %%a /F
                    
                    REM Khởi động lại backend app (ẩn cửa sổ, ghi log)
                    start /MIN java -jar library-management-backend-0.0.1-SNAPSHOT.jar --server.port=9999 >> app.log 2>&1
                '''
            }
        }
    }
}
