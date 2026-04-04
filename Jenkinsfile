pipeline {
    agent none

    environment {
        APP_NAME = 'my-flutter-app'
    }

    stages {

        // ==========================================
        // ETAP 1: Analiza + testy (Linux/Docker)
        // ==========================================
        stage('Analyze & Test') {
            agent {
                docker {
                    image 'flutter-agent'
                    args '--network host'
                }
            }
            steps {
                sh 'flutter pub get'
                sh 'flutter analyze'
                sh 'flutter test --coverage'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: '**/test-results/**/*.xml'
                }
            }
        }

        // ==========================================
        // ETAP 2: Build APK (Linux/Docker)
        // ==========================================
        stage('Build APK') {
            agent {
                docker {
                    image 'flutter-agent'
                    args '--network host'
                }
            }
            steps {
                sh 'flutter pub get'
                sh 'flutter build apk --release'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/*.apk', fingerprint: true
                }
            }
        }

        // ==========================================
        // ETAP 3: Build IPA (Mac agent)
        // ==========================================
        stage('Build IPA') {
            agent { label 'mac' }
            steps {
                sh 'flutter pub get'
                sh 'flutter build ipa --release --no-codesign'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/ios/archive/*.xcarchive/**', fingerprint: true
                }
            }
        }
    }

    post {
        failure {
            echo "Build failed: ${env.BUILD_URL}"
            // Tu możesz dodać Slack/email notification
        }
        success {
            echo "Build passed: ${env.BUILD_URL}"
        }
    }
}