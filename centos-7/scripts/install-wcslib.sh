#!/bin/bash
mkdir ${INSTALLDIR}/wcslib
cd ${INSTALLDIR}/wcslib
wget --retry-connrefused ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib.tar.bz2
tar xf wcslib.tar.bz2
cd wcslib*
./configure --prefix=${INSTALLDIR}/wcslib --with-cfitsiolib=${INSTALLDIR}/cfitsio/lib/ --with-cfitsioinc=${INSTALLDIR}/cfitsio/include/ --without-pgplot
make #-j ${J} wcslib has some issues with parallel make and it does build quite quickly anyway
make install
