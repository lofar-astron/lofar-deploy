getent group sudo &>/dev/null || groupadd sudo
${COMMAND_ADD_USER} -m ${USER} ${ADDUSER_FLAGS}
usermod -a -G sudo ${USER}
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
sed -i 's/requiretty/!requiretty/g' /etc/sudoers
