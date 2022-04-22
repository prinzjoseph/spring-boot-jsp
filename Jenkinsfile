pipeline {
    agent any

    tools {
        maven '3.8.5'
    }
    
    parameters {
        string(name: 'SERVER_IP', defaultValue: '127.0.0.1', description: 'Provide production server IP Address.')
    }

    stages {
        stage('Source') {
            steps {
                git branch: 'main', changelog: false, credentialsId: 'Blesson01', poll: false, url: 'https://github.com/Blesson01/spring-boot-jsp.git'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Deploying Artifcats') {
            steps {
                sh '''
                    version=$(grep -E "[v][0-9]\\.[0-9]\\.[0-9]" pom.xml | awk -F"[<>]" '{print $3}')
                    rsync -avzP target/news-${version}.jar root@${SERVER_IP}:/opt/news-prod.jar      
                '''
            }
        }
    }
}
