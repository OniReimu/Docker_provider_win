#FROM phusion/images4
FROM phusion/baseimage:0.9.19

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

RUN apt-get update
RUN apt-get install -y inetutils-ping net-tools python python-pip sudo git
RUN apt-get install -y ansible



#Enabling SSH
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN /usr/sbin/enable_insecure_key

RUN echo "[testhost]\n127.0.0.1" >> /etc/ansible/hosts
RUN ssh-keygen -t ecdsa -P '' -f ~/.ssh/id_ecdsa
RUN cat ~/.ssh/id_ecdsa.pub >> ~/.ssh/authorized_keys

##Disable checking

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN echo "IgnoreUserKnownHosts yes" >> /etc/ssh/sshd_config

RUN chmod 700 /root/.ssh
RUN chmod 644 /root/.ssh/authorized_keys
RUN echo "Successful!"

EXPOSE 8080
EXPOSE 3300


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

