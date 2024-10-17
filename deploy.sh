#!/bin/bash

# Define the image name for the service to push (app service in this case)
IMAGE_NAME="manoharms/react-app"
TAG="latest"

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
