pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
       stage('code cloning'){
         steps{
            git credentialsId: 'Git_Credentials', url: 'https://github.com/padhugitpractice/JenkinsDocker.git'
               }
           }
         stage('code build by maven'){
               steps{
               sh'mvn install'
           }
          } 
        
        stage('Build Docker Image'){ 
            steps{
                sh "docker build . -t padhudockerpractice/dockerfile:${DOCKER_TAG}"
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'devvvs', variable: 'devvvs')])   {
                    sh "docker login -u padhudockerpractice -p ${devvvs}"
                    sh "docker push padhudockerpractice/dockerfile:${DOCKER_TAG}"
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
    sshagent(['kubernetes']) {
    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@13.126.206.145:/home/ubuntu/"
                    script{
                        try{
                            sh "ssh ubuntu@13.126.206.145 kubectl apply -f ."
                        }
                        catch(error){
                            sh "ssh ubuntu@13.126.206.145 kubectl create -f ."
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
