#!/bin/bash
#variables
REACT_IMAGE="reactjsapplication-react-app"
TAG="guvi"
REPO_NAME_DEV="manoharms/reactapp-dev"
REPO_NAME_PROD="manoharms/reactapp-prod"
COMPOSE_FILE="docker-compose.yml"

BRANCH=$1  # First argument passed to the script (branch name)

# Step 1: Docker login
echo "Logging into Docker Hub..."
echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin

# Step 2: Push the image to the correct registry based on the branch
if [ "$BRANCH" == "dev" ]; then
    echo "Pushing image to $REACT_IMAGE:$TAG"
    docker push $REPO_NAME_DEV:$TAG
elif [ "$BRANCH" == "main" ]; then
    echo "Pushing image to $REACT_IMAGE:$TAG"
    docker push $REPO_NAME_PROD:$TAG
else
    echo "Unknown branch. Exiting."
    exit 1
fi
#step2:Running the containers
docker-compose -f $COMPOSE_FILE  up -d