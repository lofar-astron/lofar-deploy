#!/bin/bash
mkdir ${INSTALLDIR}/casarest &&
cd ${INSTALLDIR}/casarest &&
svn co --quiet https://svn.astron.nl/casarest/trunk/casarest/ src &&
mkdir build &&
cd build &&
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casarest -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio ../src/ &&
make -j ${J} &&
make install
