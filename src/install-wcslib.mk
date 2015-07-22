mkdir ${INSTALLDIR}/wcslib && \
cd ${INSTALLDIR}/wcslib && \
wget --retry-connrefused ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib-${WCSLIB_VERSION}.tar.bz2 && \
tar xf wcslib-*.tar.bz2 && \
cd wcslib* && \
./configure --prefix=${INSTALLDIR}/wcslib --with-cfitsiolib=${INSTALLDIR}/cfitsio/lib/ --with-cfitsioinc=${INSTALLDIR}/cfitsio/include/ --without-pgplot && \
make && \
make install
