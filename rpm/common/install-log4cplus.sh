mkdir -p ${INSTALLDIR}/log4cplus/build
cd ${INSTALLDIR}/log4cplus && git clone https://github.com/log4cplus/log4cplus.git -b ${LOG4CPLUS_VERSION} src
cd ${INSTALLDIR}/log4cplus/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/log4cplus ../src/
cd ${INSTALLDIR}/log4cplus/build && make -j ${J}
cd ${INSTALLDIR}/log4cplus/build && make install
