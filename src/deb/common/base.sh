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
apt-get update
apt-get upgrade -y

# admin
apt-get -y install sudo

# download
apt-get -y install git subversion wget

# build
apt-get -y install automake autotools-dev make python-setuptools

# compiler
apt-get -y install  g++ gcc gfortran

# libraries
apt-get -y install libblas-dev libfftw3-dev python-dev liblapack-dev libpng-dev libxml2-dev python-numpy libreadline-dev libncurses-dev python-scipy liblog4cplus-dev

# misc
apt-get -y install bison bzip2 flex python-xmlrunner python-pip gettext

# python packages
pip install pyfits pywcs python-monetdb unittest2
