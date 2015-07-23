mkdir ${INSTALLDIR}/wcslib
cd ${INSTALLDIR}/wcslib && wget --retry-connrefused ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib-${WCSLIB_VERSION}.tar.bz2
cd ${INSTALLDIR}/wcslib && tar xf wcslib-*.tar.bz2
cd ${INSTALLDIR}/wcslib/wcslib* && ./configure --prefix=${INSTALLDIR}/wcslib --with-cfitsiolib=${INSTALLDIR}/cfitsio/lib/ --with-cfitsioinc=${INSTALLDIR}/cfitsio/include/ --without-pgplot
cd ${INSTALLDIR}/wcslib/wcslib* && make
cd ${INSTALLDIR}/wcslib/wcslib* && make install
