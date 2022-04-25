pipeline {
    agent any

    tools {
        maven '3.8.5'
    }
    
    environment {
  version = "perl -nle 'print "$1" if /<version>(v\\d+\\.\\d+\\.\\d+)<\\/version>/' pom.xml"
}

    parameters {
        string(name: 'SERVER_IP', defaultValue: '34.207.185.8', description: 'Provide production server IP Address.')
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
              
                withAWS(credentials: 'j2s3', region: 'us-east-1') {
                  sh '''
                  
                  echo ${version}
                  
                  '''
                      s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'target/news-${version}.jar', bucket:'blessonm', path:'artifacts/')
                }
                
            }
        }
    }
}
