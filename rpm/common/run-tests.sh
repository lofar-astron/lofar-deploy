cd ${INSTALLDIR}/log4cplus/build && make test
cd ${INSTALLDIR}/casacore/build && make test 
export LD_LIBRARY_PATH=${INSTALLDIR}/casacore/lib:$LD_LIBRARY_PATH && export PYTHONPATH=${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages:${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages:$PYTHONPATH && cd ${INSTALLDIR}/python-casacore/python-casacore && nosetests
sudo /usr/sbin/sshd && cd ${INSTALLDIR}/lofar/build/gnu_opt && make test
