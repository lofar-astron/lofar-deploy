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

export BOOST_VERSION=1.69.0
mkdir -p ${INSTALLDIR}/boost
cd ${INSTALLDIR}/boost && wget https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_$(echo ${BOOST_VERSION} | sed 's/\./_/g').tar.gz
cd ${INSTALLDIR}/boost/ && tar xvf boost_*.tar.gz
cd ${INSTALLDIR}/boost/boost_* && ./bootstrap.sh --prefix=${INSTALLDIR}/boost
cd ${INSTALLDIR}/boost/boost_* && ./b2 -j ${J} cxxstd=11 --with-python  --with-date_time --with-filesystem --with-thread --with-system --with-program_options
cd ${INSTALLDIR}/boost/boost_* && ./bjam install
