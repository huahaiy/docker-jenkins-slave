#!/bin/bash

set -e

#echo jenkins-slave:$JENKINS_SLAVE_PASSWD | chpasswd
echo $JENKINS_MASTER_KEY >> /home/jenkins-slave/.ssh/authorized_keys

exec "$@"
