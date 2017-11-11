FROM huahaiy/lein
MAINTAINER Huahai Yang <huahai.yang@gmail.com>

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install git ansible openssh-server && \
  sed -i 's|session    required     pam_env.so|session    optional     pam_env.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd && \
  adduser --system --group --home /home/jenkins-slave --shell /bin/bash jenkins-slave && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

