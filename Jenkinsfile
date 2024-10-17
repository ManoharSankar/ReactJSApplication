pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = credentials('DOCKER_USERNAME') // Jenkins credentials
        DOCKERHUB_PASSWORD = credentials('DOCKER_PASS') // Jenkins credentials
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Run build.sh with the current branch name
                    if (env.BRANCH_NAME == 'dev') {
                        sh './build.sh dev'
                    } else if (env.BRANCH_NAME == 'main') {
                        sh './build.sh main'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Run deploy.sh with the current branch name
                    if (env.BRANCH_NAME == 'dev') {
                        sh './deploy.sh dev'
                    } else if (env.BRANCH_NAME == 'main') {
                        sh './deploy.sh main'
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            script{
                currentBuild.Status="SUCCESS"
            }
            emailext(
                to: 'manoharsankar93@gmail.com',
                subject: "Docker Build and Deployment Success",
                body: """
                The Docker images were successfully built and pushed.
                - **Build Number**: ${env.BUILD_NUMBER}
                - **Build Status**: ${currentBuild.result}
                - **Job Name**: ${env.JOB_NAME}
                - **Build URL**: ${env.BUILD_URL}
                """,
            attachLog: true
            )
        }
        failure {
            script{
                currentBuild.Status="FAILURE"
            }
            emailext(
                to: 'manoharsankar93@gmail.com',
                subject: "Docker Build and Deployment Failed",
                body: """
                There was an error during the Docker build or deployment."
                - **Build Number**: ${env.BUILD_NUMBER}
                - **Build Status**: ${currentBuild.result}
                - **Job Name**: ${env.JOB_NAME}
                - **Build URL**: ${env.BUILD_URL}
                """,
            attachLog: true
            )
        }
    }
}
