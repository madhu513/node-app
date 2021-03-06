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
                   withCredentials([string(credentialsId: 'docker11', variable: 'docker11')]) {
                    sh "docker login -u madhu309 -p ${docker11}"
                    sh "docker push madhu309/madhu:${DOCKER_TAG}"
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
               sshagent(['private-key']) {
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@15.206.28.49:/home/ubuntu/"
                    script{
                        try{
                            
                            sh "ssh ubuntu@15.206.28.49 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ubuntu@15.206.28.49 kubectl create -f ."
                        }
                    }
                }
            }
        }
    }
}


def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
