#!/bin/bash

# Define the image name for the service to push (app service in this case)
REACT_IMAGE="reactjsapplication-react-app"
TAG="latest"
REPO_NAME="manoharms/reactapp-dev"
COMPOSE_FILE="docker-compose.yml"
# Log in to Docker Hub
echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
# Push the Docker image to Docker Hub
docker tag $REACT_IMAGE $REPO_NAME:$TAG
docker push $REPO_NAME:$TAG

if [ $? -eq 0 ]; then
  echo "Docker image pushed successfully: $REPO_NAME:$TAG"
else
  echo "Failed to push Docker image."
  exit 1
fi
#Stop and remove containers
docker-compose -f $COMPOSE_FILE down 
#Running the containers
docker-compose -f $COMPOSE_FILE up -d
