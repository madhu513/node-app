pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    tools{
        maven 'maven'
    }
    stages{
       stage('code cloning'){
         steps{
            git credentialsId: 'Git_Credentials', url: 'https://github.com/padhugitpractice/JenkinsDocker.git'
               }
           }
         stage('code build by maven'){
               steps{
               sh'mvn clean package'
           }
          } 
        
        stage('Build Docker Image'){ 
            steps{
                sh "docker build . -t madhu309/madhu:${DOCKER_TAG}"
            }
        }
        stage('DockerHub Push'){
            steps{
               withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
                    sh "docker login -u madhu309 -p ${docker}"
                    sh "docker push madhu309/madhu:${DOCKER_TAG}"
               }
             }
          }
    }
}
