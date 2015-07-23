mkdir -p ${INSTALLDIR}/casacore/{build,data}
cd ${INSTALLDIR}/casacore && git clone https://github.com/casacore/casacore.git src
cd ${INSTALLDIR}/casacore/data && wget --retry-connrefused ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
cd ${INSTALLDIR}/casacore/data && tar xf WSRT_Measures.ztar
cd ${INSTALLDIR}/casacore/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casacore/ -DDATA_DIR=${INSTALLDIR}/casacore/data -DWCSLIB_ROOT_DIR=/${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DBUILD_PYTHON=True -DUSE_OPENMP=True -DUSE_FFTW3=TRUE ../src/
cd ${INSTALLDIR}/casacore/build && make -j ${J}
cd ${INSTALLDIR}/casacore/build && make install
