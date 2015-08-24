getent group sudo &>/dev/null || groupadd sudo
echo "useradd -m ${USERADD_FLAGS} ${USER}"
useradd -m -u ${UID} ${USER}
usermod -a -G sudo ${USER}
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
sed -i 's/requiretty/!requiretty/g' /etc/sudoers
