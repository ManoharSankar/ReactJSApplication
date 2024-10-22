pipeline {
    agent any

    environment {
        DOCKERHUB_USER = credentials('DOCKER_USERNAME') 
        DOCKERHUB_PASS = credentials('DOCKER_PASS')
        SSH_KEY = credentials('ec2-ssh-key')
        BRANCH_NAME="${env.GIT_BRANCH}"
 
    }

    stages {
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh './build.sh ${BRANCH_NAME}'
                }
            }
        }
        
        stage('Deploy Application') {
            steps {
                script {
                    sh './deploy.sh ${BRANCH_NAME}'
                }
            }
        }
        stage('Monitor Health') {
            steps {
                script {
                    echo "Health check initiated for branch ${env.BRANCH_NAME}"
                    // Add Prometheus/Grafana monitoring steps here if necessary of reactapp
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}

