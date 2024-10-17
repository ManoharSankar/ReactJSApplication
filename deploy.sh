#!/bin/bash

# Define the image name for the service to push (app service in this case)
COMPOSE_FILE="docker-compose.yml"
#Running the containers
docker-compose -f $COMPOSE_FILE up -d
