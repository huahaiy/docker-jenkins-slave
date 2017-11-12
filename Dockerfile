FROM huahaiy/lein
MAINTAINER Huahai Yang <huahai.yang@gmail.com>

ARG user=jenkins-slave
ARG group=jenkins-slave
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y --no-install-recommends install git ansible openssh-server && \
	sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config && \
	sed -i 's/#RSAAuthentication.*/RSAAuthentication yes/' /etc/ssh/sshd_config && \
	sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config && \ 
	sed -i 's/#SyslogFacility.*/SyslogFacility AUTH/' /etc/ssh/sshd_config && \ 
	sed -i 's/#LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config && \
  mkdir -p /var/run/sshd && \
	groupadd -g ${gid} ${group} && \
	useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}" && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

VOLUME "${JENKINS_AGENT_HOME}" "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY ./docker-entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/docker-entrypoint.sh"]
