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
                script {
                    def sshConfig = sh(script: 'vagrant ssh-config', returnStdout: true).trim()
                    def match = sshConfig =~ /HostName\s+(\S+)/
                    if (match) {
                        def vagrantIp = match[0][1]
                        sh "ssh vagrant@${vagrantIp} \"docker pull trinhviethoang16/frontend && docker run -d -p 3500:3000 trinhviethoang16/frontend\""
                    } else {
                        error "Failed to retrieve Vagrant IP"
                    }
                }
            }
        }
    }
}