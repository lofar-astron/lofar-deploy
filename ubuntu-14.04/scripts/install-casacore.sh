#!/bin/bash
mkdir ${INSTALLDIR}/casacore
cd ${INSTALLDIR}/casacore
git clone https://github.com/casacore/casacore.git src
mkdir build
mkdir data
cd data
wget ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
tar xf WSRT_Measures.ztar
cd ..
cd build
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casacore/ -DDATA_DIR=${INSTALLDIR}/casacore/data -DWCSLIB_ROOT_DIR=/${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DBUILD_PYTHON=True -DUSE_OPENMP=True -DUSE_FFTW3=TRUE ../src/
make -j ${J}
make install
