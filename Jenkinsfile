pipeline{
 agent any

 tools {

   maven '3.8.5'
 } 

environment {
        version = sh(
                    script: '''
                 grep -Eo "[a-z][0-9]*\\.[0-9]*\\.[0-9]*" pom.xml
                        ''',
                        returnStdout: true
                    ).trim()



 }
   stages {

       stage ('git clone') {

         steps {
           
            git branch: 'develop', changelog: false, credentialsId: 'Blesson01', poll: false, url: 'https://github.com/Blesson01/spring-boot-jsp.git'
 
         }
       }


       stage ('Build') {

         steps {
           
            sh 'mvn package'
 
         }
       }       

       stage ('Test') {

         steps {
           
            sh 'mvn test'
 
         }
       }



       stage ('Deploy') {

         steps {
           

withAWS(profile:'default') {

    sh ''' 
    echo "Upload Artifact to s3 bucket"
    echo $version 
    '''

     s3Upload(file:"target/news-${version.trim()}.jar", bucket:'news-blez', path:'new/')
              }


            }
       }


   }

}

