#!/bin/bash

REACT_IMAGE="reactjsapplication-react-app"
TAG="guvi"
REPO_NAME_DEV="manoharms/reactapp-dev"
REPO_NAME_PROD="manoharms/reactapp-prod"
BRANCH=$1  # First argument passed to the script (branch name)
COMPOSE_FILE="docker-compose.yml"

# Step 1: Remove old images based on the branch
if [ "$BRANCH" == "dev" ]; then
    echo "Removing old dev image..."
    docker rmi -f $REACT_IMAGE:$TAG || true
elif [ "$BRANCH" == "main" ]; then
    echo "Removing old prod image..."
    docker rmi -f $REACT_IMAGE:$TAG || true
fi

# Step 2: Build the Docker image using Docker Compose
echo "Building the Docker image for branch: $BRANCH..."

if [ "$BRANCH" == "dev" ]; then
    docker-compose -f $COMPOSE_FILE build
    echo "Tagging the image as $REACT_IMAGE:$TAG"
    docker tag $REACT_IMAGE:$TAG $REPO_NAME_DEV:$TAG
elif [ "$BRANCH" == "main" ]; then
    docker-compose -f $COMPOSE_FILE build
    echo "Tagging the image as $REACT_IMAGE:$TAG"
    docker tag $REACT_IMAGE:$TAG $REPO_NAME_PROD:$TAG
else
    echo "Unknown branch. Exiting."
    exit 1
fi

echo "Build completed."

# Build the images using Docker Compose
#docker-compose -f $COMPOSE_FILE build

#if [ $? -eq 0 ]; then
  #echo "Docker images built successfully using Docker Compose."
#else
  #echo "Failed to build Docker images."
  #exit 1
#fi

