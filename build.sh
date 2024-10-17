#!/bin/bash

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
