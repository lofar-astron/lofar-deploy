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

# base
yum -y update

# deltarpm
yum -y install deltarpm

# admin
yum -y install sudo

# download
yum -y install git svn wget

# build
yum -y install automake-devel aclocal autoconf autotools make

# compiler
yum -y install g++ gcc gcc-c++ gcc-gfortran

# libraries
yum -y install blas-devel fftw3-devel fftw3-libs python-devel lapack-devel libpng-devel libxml2-devel numpy-devel readline-devel ncurses-devel f2py bzip2-devel libicu-devel scipy gsl-devel

# misc
yum -y install bison flex ncurses tar bzip2 which gettext doxygen

# python packages
wget --retry-connrefused https://bootstrap.pypa.io/get-pip.py -O - | python
pip install pyfits pywcs python-monetdb xmlrunner unittest2
