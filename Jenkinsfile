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
           
            sh '''

               version=$(grep -Eo "[a-z][0-9]*\\.[0-9]*\\.[0-9]*" pom.xml)

               rsync -avzP target/news-${version}.jar   blez@54.235.232.63:/opt



            '''
 
         }
       }


   }

}

