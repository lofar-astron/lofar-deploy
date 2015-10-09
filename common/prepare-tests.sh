#
# Copyright (C) 2015
# This file is part of lofar-profiling.
# 
# lofar-profiling is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# lofar-profiling is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with lofar-profiling.  If not, see <http://www.gnu.org/licenses/>.
#

#!/bin/bash
INSTALL_SSHD_PLACEHOLDER
sudo PACKAGE_MANAGER -y install csh
mkdir -p ${HOME}/.ssh 
SSHD_SETTINGS_PLACEHOLDER
ssh-keygen -t rsa -N "" -f ${HOME}/.ssh/id_rsa 
cat ${HOME}/.ssh/id_rsa.pub > ${HOME}/.ssh/authorized_keys 
echo "StrictHostKeyChecking no" > ${HOME}/.ssh/config 
chmod 700 ${HOME}/.ssh 
chmod 600 ${HOME}/.ssh/authorized_keys 
chmod 600 ${HOME}/.ssh/id_rsa 
chmod 600 ${HOME}/.ssh/config
