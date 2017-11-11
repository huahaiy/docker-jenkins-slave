#!/bin/bash

set -e

echo $JENKINS_MASTER_KEY >> /home/jenkins-slave/.ssh/authorized_keys 

exec "$@"
