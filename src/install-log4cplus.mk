mkdir ${INSTALLDIR}/log4cplus && \
cd ${INSTALLDIR}/log4cplus && \
git clone --recursive git://github.com/log4cplus/log4cplus.git -b ${LOG4CPLUS_VERSION} src && \
mkdir build && \
cd build/ && \
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/log4cplus ../src/ && \
make -j ${J} && \
make install
