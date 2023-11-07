pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'docker-compose build' 
            }
        }
        stage('Push') { 
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHubCredentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker-compose push' 
                }
            }
        }
        stage('Deploy') { 
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d'
            }
        }
    }
}
