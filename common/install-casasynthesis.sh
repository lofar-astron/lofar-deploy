mkdir -p ${INSTALLDIR}/casasynthesis/build
cd ${INSTALLDIR}/casasynthesis && git clone https://github.com/radio-astro/casasynthesis src
cd ${INSTALLDIR}/casacore/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casasynthesis/ -DWCSLIB_ROOT_DIR=/${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore ../src/
cd ${INSTALLDIR}/casasynthesis/build && make -j ${J}
cd ${INSTALLDIR}/casasynthesis/build && make install
