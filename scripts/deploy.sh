#!/bin/bash
BUILD_PATH=$(ls /home/ec2-user/build/config/*.jar)
JAR_NAME=$(basename $BUILD_PATH)
echo "> build 파일명 : $JAR_NAME"

DEPLOY_PATH=/home/ec2-user/docker/config/
CP_JAR_PATH=$DEPLOY_PATH$JAR_NAME

echo "> copy $BUILD_PATH >> $CP_JAR_PATH"
sudo cp $BUILD_PATH $CP_JAR_PATH

DOCKER_PATH=/home/ec2-user/docker/
echo "> cd $DOCKER_PATH"
cd $DOCKER_PATH

SHELL_PATH=`pwd`
echo $SHELL_PATH

DOCKER_SERVICE_NAME=config
sudo docker-compose up -d --build ${DOCKER_SERVICE_NAME}

sudo docker image prune -f
