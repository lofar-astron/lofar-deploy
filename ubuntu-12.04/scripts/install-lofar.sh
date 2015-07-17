#!/bin/bash
mkdir ${INSTALLDIR}/lofar
cd ${INSTALLDIR}/lofar
svn --non-interactive -q --username lofar-guest --password lofar-guest co https://svn.astron.nl/LOFAR/trunk src
mkdir -p build/gnu_opt
cd build/gnu_opt
cmake -DBUILD_PACKAGES=Offline -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofar/ -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DCASAREST_ROOT_DIR=${INSTALLDIR}/casarest/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DLOG4CPLUS_ROOT_DIR=${INSTALLDIR}/log4cplus/ -DUSE_OPENMP=True ${INSTALLDIR}/lofar/src/
sed -i '29,31d' include/ApplCommon/PosixTime.h
make -j ${J}
make install
