#
# Copyright (C) 2019
# This file is part of lofar-profiling.
#
# lofar-profiling is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# lofar-profiling is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with lofar-profiling.  If not, see <http://www.gnu.org/licenses/>.
#

export PYTHON_CASACORE_VERSION=v3.0.0
mkdir ${INSTALLDIR}/python-casacore
cd ${INSTALLDIR}/python-casacore && git clone https://github.com/casacore/python-casacore
if [ "$PYTHON_CASACORE_VERSION" != "latest" ]; then cd ${INSTALLDIR}/python-casacore/python-casacore && git checkout tags/${PYTHON_CASACORE_VERSION}; fi
cd ${INSTALLDIR}/python-casacore/python-casacore && CFLAGS='-std=c++11' ./setup.py build_ext -I${INSTALLDIR}/wcslib/include:${INSTALLDIR}/casacore/include/:${INSTALLDIR}/cfitsio/include:${INSTALLDIR}/boost/include -L${INSTALLDIR}/wcslib/lib:${INSTALLDIR}/casacore/lib:${INSTALLDIR}/cfitsio/lib:/usr/lib64:${INSTALLDIR}/boost/lib -R${INSTALLDIR}/wcslib/lib:${INSTALLDIR}/casacore/lib/:${INSTALLDIR}/cfitsio/lib/
mkdir -p ${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages/
mkdir -p ${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages:${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages:$PYTHONPATH && cd ${INSTALLDIR}/python-casacore/python-casacore && ./setup.py develop --prefix=${INSTALLDIR}/python-casacore/
