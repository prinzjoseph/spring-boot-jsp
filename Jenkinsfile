pipeline {
    agent any

    tools {
        maven '3.8.5'
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
                sh '''
                   # version=$(grep -E "[v][0-9]\\.[0-9]\\.[0-9]" pom.xml | awk -F"[<>]" '{print $3}')
                   # rsync -avzP target/news-${version}.jar root@${SERVER_IP}:/opt/news-prod.jar      
                      echo 'test'            
                  '''
                withAWS(credentials: 'j2s3', region: 'us-east-1') {
                  sh '''
                  
                  version=$(grep -E "[v][0-9]\\.[0-9]\\.[0-9]" pom.xml | awk -F"[<>]" '{print $3}')
                  echo "Uploading content with AWS creds"
                  echo ${version}
                  '''
                      s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:"news-${version.trim()}.jar", bucket:'blessonm', path:'artifacts/')
                }
                
            }
        }
    }
}
