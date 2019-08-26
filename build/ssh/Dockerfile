FROM centos

MAINTAINER darebeat<darebeat@126.com>

RUN yum install -y openssh-server sudo openssh-clients wget

# ADD USER:root:root and add it into `sudoers`
# ssh login each other without password
RUN sed -i 's/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g' /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && echo "root   ALL=(ALL)       ALL" >> /etc/sudoers \
  && ssh-keygen -t rsa -b 1024 -f /root/.ssh/id_rsa -N "" \
  && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
  && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
  && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
  && cp -v /root/.ssh/{id_rsa.pub,authorized_keys}

COPY ./config /root/.ssh/

RUN chmod -v 0400 /root/.ssh/authorized_keys \
  && chmod -v 0400  /root/.ssh/config \
  && mkdir /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]