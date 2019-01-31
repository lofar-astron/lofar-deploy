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

mkdir -p ${INSTALLDIR}/hdf5/build
HDF5_VERSION_=$(echo $HDF5_VERSION | head -c 4)
cd ${INSTALLDIR}/hdf5 && wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${HDF5_VERSION_}/hdf5-${HDF5_VERSION}/src/hdf5-${HDF5_VERSION}.tar.gz
cd ${INSTALLDIR}/hdf5 && tar xvf hdf5-${HDF5_VERSION}.tar.gz
cd ${INSTALLDIR}/hdf5/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/hdf5 ../hdf5-${HDF5_VERSION}
cd ${INSTALLDIR}/hdf5/build && make -j ${J}
cd ${INSTALLDIR}/hdf5/build && make install
