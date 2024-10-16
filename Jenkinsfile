pipeline {
    agent any

    environment {
        // Set your Docker Hub credentials
        DOCKER_HUB_CREDENTIALS = 'dockerhub-credentials'  // Replace with Jenkins credential ID
        DOCKER_HUB_REPO = 'your_dockerhub_repo'     // Replace with your Docker Hub repository
        IMAGE_NAME = 'your_image_name'              // Replace with your image name
        GIT_REPO = 'https://github.com/your/repo.git' // Replace with your GitHub repo URL
        BRANCH = $Branch                              // Replace with your branch name
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                // Execute the build.sh script
                script{
                    chmod +x build.sh
                    ./build.sh
                }
                
            }
        }

/*        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh """
                    docker build -t ${DOCKER_HUB_REPO}/${IMAGE_NAME}:${BUILD_NUMBER} .
                    """
                }
            }
        }*/

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub and push the image
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                        sh """
                        echo ${DOCKER_HUB_PASSWORD} | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin
                        docker push ${DOCKER_HUB_REPO}/${IMAGE_NAME}:${BUILD_NUMBER}
                        """
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Execute the deploy.sh script to pull the image and start the app with Docker Compose
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            script {
                currentBuild.result = 'SUCCESS'
            }
            emailext(
                to: 'manoharsankar93@gmail.com',
                subject: "Jenkins Build SUCCESS: ${currentBuild.fullDisplayName}",
                body: """
                The build was successful!

                - **Build Number**: ${env.BUILD_NUMBER}
                - **Build Status**: ${currentBuild.result}
                - **Job Name**: ${env.JOB_NAME}
                - **Build URL**: ${env.BUILD_URL}

                Please check the details in Jenkins.
                """,
		attachLog: true
            )
        }
        failure {
            script {
                currentBuild.result = 'FAILURE'
            }
            emailext(
                to: 'manoharsankar93@gmail.com',
                subject: "Jenkins Build FAILURE: ${currentBuild.fullDisplayName}",
                body: """
                The build failed.

                - **Build Number**: ${env.BUILD_NUMBER}
                - **Build Status**: ${currentBuild.result}
                - **Job Name**: ${env.JOB_NAME}
                - **Build URL**: ${env.BUILD_URL}

                Please check the details in Jenkins.
                """,
		attachLog: true
            )
        }
    }
}
