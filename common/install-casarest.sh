mkdir -p ${INSTALLDIR}/casarest/build
cd ${INSTALLDIR}/casarest && git clone https://github.com/casacore/casarest.git src
if [ "${CASAREST_VERSION}" != "latest" ]; then cd ${INSTALLDIR}/casarest/src && git checkout tags/${CASAREST_VERSION}; fi
cd ${INSTALLDIR}/casarest/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casarest -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio ../src/
cd ${INSTALLDIR}/casarest/build && make -j ${J}
cd ${INSTALLDIR}/casarest/build && make install
