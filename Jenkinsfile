pipeline {
    agent any 
    stages {
        stage('Clone') { 
            steps {
                git branch: 'develop', url: 'https://github.com/trinhviethoang16/frontend-nextjs.git'
            }
        }
        stage('Build') { 
            steps {
                sh 'docker build -t trinhviethoang16/frontend:develop .' 
            }
        }
        stage('Tag') { 
            steps {
                sh 'docker tag frontend trinhviethoang16/frontend:develop' 
            }
        }
        stage('Deploy') { 
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHubCredentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                    sh 'docker push trinhviethoang16/frontend:develop' 
                }
            }
        }
    }
}