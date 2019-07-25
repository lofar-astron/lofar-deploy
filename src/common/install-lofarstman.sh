#
# Copyright (C) 2019
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

export LOFARSTMAN_VERSION=master
mkdir -p ${INSTALLDIR}/lofarstman/build
cd ${INSTALLDIR}/lofarstman && wget https://github.com/lofar-astron/LofarStMan/archive/${LOFARSTMAN_VERSION}.tar.gz
cd ${INSTALLDIR}/lofarstman && tar xvf ${LOFARSTMAN_VERSION}.tar.gz
cd ${INSTALLDIR}/lofarstman/build && cmake -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofarstman ../LofarStMan-master
cd ${INSTALLDIR}/lofarstman/build && make -j ${J}
cd ${INSTALLDIR}/lofarstman/build && make install
