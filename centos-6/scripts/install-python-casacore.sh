#!/bin/bash
mkdir ${INSTALLDIR}/python-casacore
cd ${INSTALLDIR}/python-casacore
git clone https://github.com/casacore/python-casacore
cd python-casacore/
./setup.py build_ext -I${INSTALLDIR}/wcslib/include:${INSTALLDIR}/casacore/include/:${INSTALLDIR}/cfitsio/include -L${INSTALLDIR}/wcslib/lib:${INSTALLDIR}/casacore/lib/:${INSTALLDIR}/cfitsio/lib/
mkdir -p ${INSTALLDIR}/python-casacore/lib/python2.6/site-packages/
mkdir -p ${INSTALLDIR}/python-casacore/lib64/python2.6/site-packages/
export PYTHONPATH=${INSTALLDIR}/python-casacore/lib/python2.6/site-packages/:${INSTALLDIR}/python-casacore/lib64/python2.6/site-packages/:${PYTHONPATH}
./setup.py install --prefix=${INSTALLDIR}/python-casacore/
