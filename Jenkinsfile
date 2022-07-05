pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('Dockerhub')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t blesson03/jenkinz:${BUILD_NUMBER} .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push blesson03/jenkinz:${BUILD_NUMBER}'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}