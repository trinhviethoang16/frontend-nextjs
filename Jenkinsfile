pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'docker build -t frontend .' 
                // sh 'docker-compose up --build'
            }
        }
        stage('Tag') { 
            steps {
                sh 'docker tag frontend trinhviethoang16/frontend'
            }
        }
        stage('Push') { 
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHubCredentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push trinhviethoang16/frontend' 
                }
            }
        }
        stage('Deploy') { 
            steps {
                sh 'docker stop frontend || true'
                sh 'docker rm frontend || true'
                sh 'docker pull trinhviethoang16/frontend && docker run -d -p 3000:3000 trinhviethoang16/frontend'
            }
        }
    }
}