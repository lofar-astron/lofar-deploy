mkdir -p ${INSTALLDIR}/casarest/build
cd ${INSTALLDIR}/casarest && svn checkout --quiet https://svn.astron.nl/casarest/release/casarest/release-${CASAREST_VERSION} src
cd ${INSTALLDIR}/casarest/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casarest -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio ../src/
cd ${INSTALLDIR}/casarest/build && make -j ${J}
cd ${INSTALLDIR}/casarest/build && make install
