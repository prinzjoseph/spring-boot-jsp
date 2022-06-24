pipeline{
 agent any

 tools {

   maven '3.8.5'
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
           
s3CopyArtifact buildSelector: lastSuccessful(stable: true), excludeFilter: '', filter: '', flatten: false, optional: false, projectName: 'spring-test1', target: 'news-blez/new/'
         }
       }


   }

}

