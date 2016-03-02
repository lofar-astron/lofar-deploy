#
# Copyright (C) 2015
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
zypper --non-interactive update

# admin
zypper --non-interactive install sudo

# download
zypper --non-interactive install git subversion wget

# build
zypper --non-interactive install automake autoconf cmake make

# compiler
zypper --non-interactive install gcc gcc-c++ gcc-fortran

# libraries
zypper --non-interactive install blas-devel boost-devel fftw3-devel fftw3-threads-devel python-devel lapack-devel libpng16-compat-devel libxml2-devel python-numpy-devel readline-devel ncurses-devel libicu-devel python-scipy

# misc
zypper --non-interactive install bison flex ncurses tar bzip2 which python-pip

# python packages
pip install --upgrade pip
pip install pyfits pywcs python-monetdb xmlrunner
