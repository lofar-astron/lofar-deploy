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

export WCSLIB_VERSION=6.3
mkdir ${INSTALLDIR}/wcslib
cd ${INSTALLDIR}/wcslib && wget --retry-connrefused ftp://anonymous@ftp.atnf.csiro.au/pub/software/wcslib/wcslib-${WCSLIB_VERSION}.tar.bz2 -O wcslib-${WCSLIB_VERSION}.tar.bz2
cd ${INSTALLDIR}/wcslib && tar xf wcslib-${WCSLIB_VERSION}.tar.bz2
cd ${INSTALLDIR}/wcslib/wcslib-${WCSLIB_VERSION} && ./configure --prefix=${INSTALLDIR}/wcslib --with-cfitsiolib=${INSTALLDIR}/cfitsio/lib/ --with-cfitsioinc=${INSTALLDIR}/cfitsio/include/ --without-pgplot
cd ${INSTALLDIR}/wcslib/wcslib* && make
cd ${INSTALLDIR}/wcslib/wcslib* && make install
