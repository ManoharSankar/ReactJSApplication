pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    // Run the build script
                    sh 'chmod +x build.sh && ./build.sh'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Run the deploy script
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
            mail to: 'manoharsankar93@gmail.com',
                 subject: "Docker Compose Build and Deployment Success",
                 body: "The Docker images were built and deployed successfully using Docker Compose and pushed to Docker Hub."
        }
        failure {
            mail to: 'manoharsankar93@gmail.com',
                 subject: "Docker Compose Build and Deployment Failed",
                 body: "There was an error during the Docker Compose build or deployment process."
        }
    }
}