pipeline {
    agent any

    tools {
        maven '3.8.5'
    }

    stages {
        stage('Source') {
            steps {
                git branch: 'develop', changelog: false, credentialsId: 'be8573c2-78ad-49a8-9119-95feb5bc8c5e', poll: false, url: 'https://github.com/prinzjoseph/spring-boot-jsp.git'
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
        stage('Copying Artifcats') {
            steps {
                sh '''
                    version=$(perl -nle 'print "$1" if /<version>(v\\d+\\.\\d+\\.\\d+)<\\/version>/' pom.xml)
                    rsync -av target/news-${version}.jar root@3.111.53.6:/root/news-service/news-service.jar
                    rsync -av deploy.sh root@3.111.53.6:/root/news-service/deploy.sh
                    ssh root@3.111.53.6 "bash /root/news-service/deploy.sh"
                '''
            }
        }
    }
}
