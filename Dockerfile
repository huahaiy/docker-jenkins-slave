FROM huahaiy/lein
MAINTAINER Huahai Yang <huahai.yang@gmail.com>

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install git openssh-server && \
  sed -i 's|session    required     pam_env.so|session    optional     pam_env.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd && \
  adduser --system --group --home=/home/jenkins-slave --disabled-password --shell /bin/bash jenkins-slave && \
  install -d - 700 -o jenkins-slave -g jenkins-slave /home/jenkins-slave/.ssh && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

