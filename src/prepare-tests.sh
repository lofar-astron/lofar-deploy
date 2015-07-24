#!/bin/bash
mkdir -p ${HOME}/.ssh 
ssh-keygen -t rsa -N "" -f ${HOME}/.ssh/id_rsa 
cat ${HOME}/.ssh/id_rsa.pub > ${HOME}/.ssh/authorized_keys 
echo "StrictHostKeyChecking no" > ${HOME}/.ssh/config 
chmod 700 ${HOME}/.ssh 
chmod 600 ${HOME}/.ssh/authorized_keys 
chmod 600 ${HOME}/.ssh/id_rsa 
chmod 600 ${HOME}/.ssh/config
