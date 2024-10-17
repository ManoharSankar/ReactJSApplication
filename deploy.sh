#!/bin/bash

# Define the image name for the service to push (app service in this case)
IMAGE_NAME="manoharms/reactapp-dev"
TAG="latest"
COMPOSE_FILE="docker-compose.yml"
#Running the containers
docker-compose -f $COMPOSE_FILE up -d

# Log in to Docker Hub
docker login -u $DOCKER_USERNAME -p $DOCKER_PASS
# Push the Docker image to Docker Hub
docker push $IMAGE_NAME:$TAG

if [ $? -eq 0 ]; then
  echo "Docker image pushed successfully: $IMAGE_NAME:$TAG"
else
  echo "Failed to push Docker image."
  exit 1
fi
