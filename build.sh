#!/bin/bash

REACT_IMAGE="reactjsapplication-react-app"
TAG="latest"
REPO_NAME="manoharms/reactapp-dev"
# Step 1: Remove existing images
echo "Removing existing Docker images..."
docker rmi -f $REACT_IMAGE:latest 

# Define the Docker Compose file
COMPOSE_FILE="docker-compose.yml"

# Build the images using Docker Compose
docker-compose -f $COMPOSE_FILE build

if [ $? -eq 0 ]; then
  echo "Docker images built successfully using Docker Compose."
else
  echo "Failed to build Docker images."
  exit 1
fi
# Log in to Docker Hub
docker login -u $DOCKER_USERNAME -p $DOCKER_PASS
# Push the Docker image to Docker Hub
docker push $REPO_NAME:$TAG

if [ $? -eq 0 ]; then
  echo "Docker image pushed successfully: $REPO_NAME:$TAG"
else
  echo "Failed to push Docker image."
  exit 1
fi

