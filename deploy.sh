#!/bin/bash

COMPOSE_FILE="docker-compose.yml"
# Step 1: Stop and remove running containers
echo "Stopping running containers..."
docker-compose -f $COMPOSE_FILE down
#step2:Running the containers
docker-compose -f $COMPOSE_FILE up -d