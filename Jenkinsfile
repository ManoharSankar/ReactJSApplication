pipeline {
    agent any

    environment {
        DOCKERHUB_USER = credentials('dockerhub-username') 
        DOCKERHUB_PASS = credentials('dockerhub-password')
        SSH_KEY = credentials('ec2-ssh-key') 
    }

    stages {
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh './build.sh ${env.BRANCH_NAME}'
                }
            }
        }
        
        stage('Deploy Application') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sh './deploy.sh dev'
                }
            }
        }
        
        stage('Deploy Application to Production') {
            when {
                branch 'main'
            }
            steps {
                script {
                    sh './deploy.sh main'
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

