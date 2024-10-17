#!/bin/bash

COMPOSE_FILE="docker-compose.yml"

#Running the containers
docker-compose -f $COMPOSE_FILE up -d