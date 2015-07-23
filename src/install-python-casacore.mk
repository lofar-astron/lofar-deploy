mkdir ${INSTALLDIR}/python-casacore
cd ${INSTALLDIR}/python-casacore && git clone https://github.com/casacore/python-casacore
cd ${INSTALLDIR}/python-casacore/python-casacore ./setup.py build_ext -I${INSTALLDIR}/wcslib/include:${INSTALLDIR}/casacore/include/:${INSTALLDIR}/cfitsio/include -L${INSTALLDIR}/wcslib/lib:${INSTALLDIR}/casacore/lib/:${INSTALLDIR}/cfitsio/lib/
mkdir -p ${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages/
mkdir -p ${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages/
cd ${INSTALLDIR}/python-casacore/python-casacore ./setup.py install --prefix=${INSTALLDIR}/python-casacore/
