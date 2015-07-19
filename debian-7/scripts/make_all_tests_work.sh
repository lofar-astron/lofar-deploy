#!/bin/bash
sudo apt-get -y install openssh-server
sudo mkdir -p /var/run/sshd
sudo /usr/sbin/sshd
mkdir -p ${HOME}/.ssh
ssh-keygen -t rsa -N "" -f ${HOME}/.ssh/id_rsa
cat ${HOME}/.ssh/id_rsa.pub > ${HOME}/.ssh/authorized_keys
