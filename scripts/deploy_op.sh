#!/bin/sh
#
#chkconfig:234 90 90
#descript: configserver service
#processname : configserver
#
JAVA_HOME=/usr/lib/jvm/jre
SERVICE_NAME=configserver
PATH_TO_JAR=/home/ec2-user/build/configserver/configserver-0.0.1-SNAPSHOT.jar
PID_PATH_NAME=/tmp/configserver-pid
JAVA_OPTS="-server -Dspring.profiles.active=op"
PATH=$PATH:JAVA_HOME/bin
PID=`ps aux | grep configserver | grep -v grep | awk '{print $2}'`

BUILD_PATH=$(ls /home/ec2-user/build/configserver/*.jar)
JAR_NAME=$(basename $BUILD_PATH)
echo "> build 파일명 : $JAR_NAME"

DEPLOY_PATH=/home/ec2-user/deploy/configserver/
CP_JAR_PATH=$DEPLOY_PATH$JAR_NAME

echo "> copy $BUILD_PATH >> $CP_JAR_PATH"
sudo cp $BUILD_PATH $CP_JAR_PATH

echo "$PID"
            if [[ "" !=  "$PID" ]]; then
              echo "killing $PID"
              kill -9 $PID
              echo "$SERVICE_NAME stopped ..."
                  java $JAVA_OPTS -jar $CP_JAR_PATH /tmp 2>> /dev/null >> /dev/null &
              echo $! > $PID_PATH_NAME
              echo "$SERVICE_NAME started ..."
           else
                java $JAVA_OPTS -jar $CP_JAR_PATH /tmp 2>> /dev/null >> /dev/null &
              echo $! > $PID_PATH_NAME
              echo "$SERVICE_NAME started ..."
           fi
