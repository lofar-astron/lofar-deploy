cd ${INSTALLDIR}/log4cplus/build && make test
cd ${INSTALLDIR}/casacore/build && make test 
sudo /usr/sbin/sshd && cd ${INSTALLDIR}/lofar/build/gnu_opt && make test
