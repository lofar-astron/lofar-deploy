mkdir -p ${INSTALLDIR}/cfitsio/build
cd ${INSTALLDIR}/cfitsio && wget --retry-connrefused ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio${CFITSIO_VERSION}.tar.gz
cd ${INSTALLDIR}/cfitsio && tar xf cfitsio${CFITSIO_VERSION}.tar.gz
cd ${INSTALLDIR}/cfitsio/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/cfitsio/ ../cfitsio
cd ${INSTALLDIR}/cfitsio/build && make -j ${J}
cd ${INSTALLDIR}/cfitsio/build && make install
