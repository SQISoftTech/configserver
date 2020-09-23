#!/bin/sh
#
#chkconfig:234 90 90
#descript: configserver service
#processname : configserver
#
JAVA_HOME=/usr/lib/jvm/jre
SERVICE_NAME=configserver
PATH_TO_JAR=/home/ec2-user/build/config/configserver-0.0.1-SNAPSHOT.jar
PID_PATH_NAME=/tmp/configserver-pid
JAVA_OPTS="-server -Dspring.profiles.active=op"
PATH=$PATH:JAVA_HOME/bin
PID=`ps aux | grep configserver | grep -v grep | awk '{print $2}'`

echo "$PID"
            if [[ "" !=  "$PID" ]]; then
              echo "killing $PID"
              kill -9 $PID
              echo "$SERVICE_NAME stopped ..."
                  java $JAVA_OPTS -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
              echo $! > $PID_PATH_NAME
              echo "$SERVICE_NAME started ..."
           else
                java $JAVA_OPTS -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
              echo $! > $PID_PATH_NAME
              echo "$SERVICE_NAME started ..."
           fi
