#!/bin/bash

set -x

BRANCH_NAME=$1
SERVER_USER=ec2-user
SERVER_IP=3.111.168.110
SSH_KEY_PATH= ~/.ssh/id_rsa
DOCKER_DEV_REPO=manoharms/react-app-dev:dev-latest
DOCKER_PROD_REPO=manoharms/react-app-prod:prod-latest

if [ "$BRANCH_NAME" == "dev" ]; then
    DOCKER_IMAGE=$DOCKER_DEV_REPO
    NODE_ENV=development
elif [ "$BRANCH_NAME" == "main" ]; then
    DOCKER_IMAGE=$DOCKER_PROD_REPO
    NODE_ENV=production
else
    echo "Unsupported branch: $BRANCH_NAME"
    exit 1
fi

echo "DOCKER_IMAGE=$DOCKER_IMAGE" > .env
echo "NODE_ENV=$NODE_ENV" >> .env

scp -i $SSH_KEY_PATH docker-compose.yml .env $SERVER_USER@$SERVER_IP:/home/ec2-user/app/

ssh -i $SSH_KEY_PATH $SERVER_USER@$SERVER_IP << 'ENDSSH'
    cd /home/ec2-user/app/
    docker-compose pull
    docker-compose up -d
ENDSSH

