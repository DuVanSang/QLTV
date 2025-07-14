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

        stage('Stop Old App') {
            steps {
                bat '''
                    powershell -Command "Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -like '*library-management-backend*' } | ForEach-Object { Write-Host 'Killing PID:' $_.ProcessId; Stop-Process -Id $_.ProcessId -Force }"
                '''
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
                    start /B java -jar backend\\target\\library-management-backend-0.0.1-SNAPSHOT.jar --server.port=9999
                '''
            }
        }
    }
}

