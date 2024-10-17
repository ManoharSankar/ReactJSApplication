#!/bin/bash

REACT_IMAGE="reactjsapplication-react-app"
TAG="latest"
COMPOSE_FILE="docker-compose.yml"
# Step 1: Remove existing images
echo "Removing existing Docker images..."
docker rmi -f $REACT_IMAGE:$TAG 

# Build the images using Docker Compose
docker-compose -f $COMPOSE_FILE build

if [ $? -eq 0 ]; then
  echo "Docker images built successfully using Docker Compose."
else
  echo "Failed to build Docker images."
  exit 1
fi


