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
                    REM Kill tiến trình theo PID cũ nếu tồn tại
                    if exist backend\\target\\app.pid (
                        set /p pid=<backend\\target\\app.pid
                        echo Killing PID: %pid%
                        taskkill /F /PID %pid%
                        del backend\\target\\app.pid
                    )

                    REM Build lại
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

                    REM Kill lại nếu app vẫn còn (dự phòng)
                    if exist app.pid (
                        set /p pid=<app.pid
                        echo Killing existing app with PID: %pid%
                        taskkill /F /PID %pid%
                        del app.pid
                    )

                    REM Start app và lưu PID
                    start /B cmd /c "java -jar library-management-backend-0.0.1-SNAPSHOT.jar --server.port=9999 > app.log 2>&1 & echo !^! > app.pid"
                '''
            }
        }
    }
}
