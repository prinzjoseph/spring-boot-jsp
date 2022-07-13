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
        stage('Building our image') { 

            steps { 

                script { 

                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 

                }

            } 

        }

        stage('Deploy our image') { 

            steps { 

                script { 

                    docker.withRegistry( '', registryCredential ) { 

                         dockerImage.push() 

                    }

                } 

            }

        } 

        stage('Cleaning up') { 

            steps { 

                  sh "docker rmi $registry:$BUILD_NUMBER" 

            }

        }
        stage('deploy on K8') { 

            steps { 

                  sh '''
                  echo $BUILD_NUMBER 
                  cat deployment.yaml | sed "s/BUILD_NUMBER/$BUILD_NUMBER/g" > newdeployment.yml
                 rsync -avzP -o StrictHostKeyChecking=no *.yml root@3.85.103.173:/root/check/
                 ssh  -o StrictHostKeyChecking=no root@3.85.103.173 "cd /root/check/ &&  kubectl apply -f newdeployment.yml " 
                 ssh  -o StrictHostKeyChecking=no root@3.85.103.173 "cd /root/check/ &&  kubectl apply -f service.yml "
                  ''' 

            }

        } 
 

    }

}