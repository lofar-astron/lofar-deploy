#!/bin/bash
useradd -m ${USER} &&
usermod -a -G sudo ${USER} &&
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
