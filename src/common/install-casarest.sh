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

mkdir -p ${INSTALLDIR}/casarest/build
cd ${INSTALLDIR}/casarest && git clone https://github.com/casacore/casarest.git src
if [ "${CASAREST_VERSION}" != "latest" ]; then cd ${INSTALLDIR}/casarest/src && git checkout tags/${CASAREST_VERSION}; fi
cd ${INSTALLDIR}/casarest/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casarest -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio ../src/ -DHDF5_ROOT_DIR=${INSTALDIR}/hdf5
cd ${INSTALLDIR}/casarest/build && make -j ${J}
cd ${INSTALLDIR}/casarest/build && make install
