pipeline { 

    environment { 

        registry = "blesson03/jenkinz" 

        registryCredential = 'Dockerhub' 

        dockerImage = '' 

    }

    agent any 

    stages { 

        stage('Cloning our Git') { 

            steps { 

                git branch: 'docker1', changelog: false, credentialsId: 'Blesson01', poll: false, url: 'https://github.com/Blesson01/spring-boot-jsp.git'

            }

        } 


   }

}