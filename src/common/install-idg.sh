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

mkdir -p ${INSTALLDIR}/idg/build
cd ${INSTALLDIR}/idg && git clone https://gitlab.com/astron-idg/idg.git
cd ${INSTALLDIR}/idg/build && cmake .. -DBUILD_LIB_CUDA=True -DREPORT_TOTAL=True -DREPORT_VERBOSE=True -DCMAKE_BUILD_TYPE=Debug -DBUILD_WITH_TESTS=True -DBUILD_WITH_PYTHON=True -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/idg ../idg
cd ${INSTALLDIR}/idg/build && make -j ${J}
cd ${INSTALLDIR}/idg/build && make install
