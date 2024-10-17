pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = credentials('DOCKER_USERNAME') // Jenkins credentials for Docker Hub username
        DOCKERHUB_PASSWORD = credentials('DOCKER_PASS') // Jenkins credentials for Docker Hub password
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'chmod +x build.sh && ./build.sh'
                    }
                }
            }
        }
        stage('Deploy to Docker Hub') {
            steps {
                script {
                    sh 'chmod +x deploy.sh && ./deploy.sh'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            mail to: 'your-email@example.com',
                 subject: "Docker Build and Deployment Success",
                 body: "The Docker images were successfully built and pushed."
        }
        failure {
            mail to: 'your-email@example.com',
                 subject: "Docker Build and Deployment Failed",
                 body: "There was an error during the Docker build or deployment."
        }
    }
}
