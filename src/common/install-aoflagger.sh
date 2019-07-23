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

export AOFLAGGER_VERSION=v2.12.1
mkdir -p ${INSTALLDIR}/aoflagger/build
cd ${INSTALLDIR}/aoflagger && git clone git://git.code.sf.net/p/aoflagger/code aoflagger
cd ${INSTALLDIR}/aoflagger/aoflagger && git checkout tags/${AOFLAGGER_VERSION}
cd ${INSTALLDIR}/aoflagger/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/aoflagger/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio -DBUILD_SHARED_LIBS=ON ../aoflagger
cd ${INSTALLDIR}/aoflagger/build && make -j ${J}
cd ${INSTALLDIR}/aoflagger/build && make install
