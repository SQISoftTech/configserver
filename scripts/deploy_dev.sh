#!/bin/sh
#
#chkconfig:234 90 90
#descript: psapisserver service
#processname : psapiserver
#
JAVA_HOME=/usr/lib/jvm/jre
SERVICE_NAME=configserver
PATH_TO_JAR=/usr/share/api_server/configserver/configserver-0.0.1-SNAPSHOT.jar
PID_PATH_NAME=/tmp/configserver-pid
JAVA_OPTS="-server -Dspring.profiles.active=dev"
PATH=$PATH:$JVA_HOME/bin

        echo "Starting $SERVICE_NAME ..."
        echo "$PID_PATH_NAME"
        if [ ! -f $PID_PATH_NAME ]; then
            sudo nohup java $JAVA_OPTS -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
            echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
             echo "$SERVICE_NAME stoping ..."
             sudo ps -elf | grep $PATH_TO_JAR | grep -v grep |  awk '{print $4}' | while read line; do kill $line; done
             echo "$SERVICE_NAME stopped ..."
             sudo rm -f $PID_PATH_NAME
             sudo nohup java $JAVA_OPTS -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
             echo $! > $PID_PATH_NAME
             echo "$SERVICE_NAME started ..."
        fi
