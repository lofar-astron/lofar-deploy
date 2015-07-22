mkdir -p ${INSTALLDIR}/cfitsio && \
cd ${INSTALLDIR}/cfitsio && \
wget --retry-connrefused ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio${CFITSIO_VERSION}.tar.gz && \
tar xf cfitsio${CFITSIO_VERSION}.tar.gz && \
mkdir build && \
cd build && \
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/cfitsio/ ../cfitsio && \
make -j ${J} && \
make install
