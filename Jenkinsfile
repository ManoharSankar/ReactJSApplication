pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = credentials('DOCKER_USERNAME') // Jenkins credentials
        DOCKERHUB_PASSWORD = credentials('DOCKER_PASS') // Jenkins credentials
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    // Run build.sh to build Docker images using Docker Compose
                    sh 'chmod +x build.sh && ./build.sh'
                }
            }
        }

        stage('Deploy to Docker Hub') {
            when {
                branch 'dev' // Only run this stage when on the 'dev' branch
            }
            steps {
                script {
                    echo "Pushing to reactapp-dev registry"
                    // Log in to Docker Hub
                    sh '''
                    echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                    docker tag reactjsapplication-react-app manoharms/reactapp-dev:latest
                    docker push manoharms/reactapp-dev:latest
                    chmod +x deploy.sh && ./deploy.sh
                    '''
                }
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main' // Only run this stage when on the 'main' branch
            }
            steps {
                script {
                    echo "Pushing to reactapp-prod registry"
                    // Log in to Docker Hub
                    sh '''
                    echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                    docker tag reactjsapplication-react-app manoharms/reactapp-prod:latest
                    docker push manoharms/reactapp-prod:latest
                    chmod +x deploy.sh && ./deploy.sh
                    '''
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
                 subject: "Docker Build and Deployment Success",
                 body: "The Docker images were successfully built and pushed."
        }
        failure {
            mail to: 'manoharsankar93@gmail.com',
                 subject: "Docker Build and Deployment Failed",
                 body: "There was an error during the Docker build or deployment"
        }
    }
}
