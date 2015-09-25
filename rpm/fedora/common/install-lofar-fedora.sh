mkdir -p ${INSTALLDIR}/lofar/build/gnu_opt
if [ "${LOFAR_VERSION}" == "latest" ]; then cd ${INSTALLDIR}/lofar && svn --non-interactive -q --username lofar-guest --password lofar-guest co https://svn.astron.nl/LOFAR/trunk src; fi
if [ "${LOFAR_VERSION}" != "latest" ]; then cd ${INSTALLDIR}/lofar && svn --non-interactive -q --username lofar-guest --password lofar-guest co https://svn.astron.nl/LOFAR/tags/LOFAR-Release-${LOFAR_VERSION} src; fi
sed -i -e '28i#include <cstring>' -e 's/memcpy/std::memcpy/' ${INSTALLDIR}/lofar/src/CEP/DP3/AOFlagger/src/msio/image2d.cpp
cd ${INSTALLDIR}/lofar/build/gnu_opt && cmake -DBUILD_PACKAGES=Offline -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofar/ -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DCASAREST_ROOT_DIR=${INSTALLDIR}/casarest/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DLOG4CPLUS_ROOT_DIR=${INSTALLDIR}/log4cplus/ -DUSE_OPENMP=True ${INSTALLDIR}/lofar/src/
cd ${INSTALLDIR}/lofar/build/gnu_opt && make -j ${J}
cd ${INSTALLDIR}/lofar/build/gnu_opt && make install
