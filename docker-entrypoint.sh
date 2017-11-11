#!/bin/bash

set -e

echo jenkins-slave:$JENKINS_SLAVE_PASSWD | chpasswd

exec "$@"
