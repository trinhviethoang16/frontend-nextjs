pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'docker build -t fe-nextjs .' 
                sh 'docker-compose up --build'
            }
        }
        stage('Tag') { 
            steps {
                sh 'docker tag fe-nextjs trinhviethoang16/frontend'
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
                sshagent(credentials: ['vagrant-ssh']) {
                    sh 'ssh vagrant@192.168.21.128 "docker pull trinhviethoang16/frontend && docker run -d -p 3000:3000 trinhviethoang16/frontend"'
                }
            }
        }
    }
}