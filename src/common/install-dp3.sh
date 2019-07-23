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

export DP3_VERSION=4.1
mkdir -p ${INSTALLDIR}/dp3/build
cd ${INSTALLDIR}/dp3 && wget https://github.com/lofar-astron/DP3/archive/v${DP3_VERSION}.tar.gz
cd ${INSTALLDIR}/dp3 && tar xvf v${DP3_VERSION}.tar.gz
sed -i '/e.printError/d' ${INSTALLDIR}/dp3/DP3-${DP3_VERSION}/DPPP/SolTab.cc
cd ${INSTALLDIR}/dp3/build && cmake ../DP3-${DP3_VERSION} -DHDF5_ROOT=${INSTALLDIR}/hdf5 -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore  -DCFITSIO_LIBRARY=${INSTALLDIR}/cfitsio/lib/libcfitsio.so -DCFITSIO_INCLUDE_DIR=${INSTALLDIR}/cfitsio/include -DAOFLAGGER_INCLUDE_DIR=${INSTALLDIR}/aoflagger/include -DAOFLAGGER_LIB=${INSTALLDIR}/aoflagger/lib/libaoflagger.so -DCMAKE_PREFIX_PATH=${INSTALLDIR}/lofarbeam -DBoost_INCLUDE_DIR=${INSTALLDIR}/boost/include -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/dp3
cd ${INSTALLDIR}/dp3/build && CPATH=${INSTALLDIR}/boost/include:${CPATH} make -j ${J}
cd ${INSTALLDIR}/dp3/build && make install
