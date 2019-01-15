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

mkdir -p ${INSTALLDIR}/wsclean/build
cd ${INSTALLDIR}/wsclean && git clone https://git.code.sf.net/p/wsclean/code wsclean
cd ${INSTALLDIR}/wsclean/build && cmake -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DCASACORE_INCLUDE_DIRS=${INSTALLDIR}/casasore/include -DCFITSIO_LIBRARY=${INSTALLDIR}/cfitsio/lib/libcfitsio.so -DCFITSIO_INCLUDE_DIR=${INSTALLDIR}/cfitsio/include -DHDF5_ROOT=${INSTALLDIR}/hdf5 -DIDGAPI_DIR=${INSTALLDIR}/idg -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/wsclean ${INSTALLDIR}/wsclean/wsclean/wsclean
cd ${INSTALLDIR}/wsclean/build && make -j ${J}
cd ${INSTALLDIR}/wsclean/build && make install
