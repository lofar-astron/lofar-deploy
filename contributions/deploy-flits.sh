# 
#     Install script for lofar 2.18.0 
#     Copyright (C) 2016  ASTRON (Netherlands Institute for Radio Astronomy)
#     P.O.Box 2, 7990 AA Dwingeloo, The Netherlands
# 
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program. If not, see <http://www.gnu.org/licenses/>.
# 

export INSTALLDIR=/home/lofar/lofar_local/    # PLEASE CONFIGURE

export PYTHON_VERSION=2.7 # Probably worth checking although I think 2.7 is required anyway
#NB: ``latest'' versions are the latest trunk versions. If you want any guarantee of stability, always use either a committed version and tweak the script, or a release and keep it as is.
export CASACORE_VERSION=v2.1.0 
export CASAREST_VERSION=v1.4.1 
export PYTHON_CASACORE_VERSION=2.1.2 
export BOOST_VERSION=1.58
export AOFLAGGER_VERSION=2.8.0
export LOFAR_BRANCH=branches/LOFAR-Release-2_18 
export LOFAR_REVISION=35323 
export LOFAR_BUILDVARIANT=gnucxx11_optarch
#export LOFAR_BUILDVARIANT=gnu_optarch
export WSCLEAN_VERSION=2.0
export LSMTOOL_VERSION=8be3ebe0888b3546db81d8dd11adea45406cffe1
export PYDS9_VERSION=1.8.1
export RMEXTRACT_VERSION=775e8ec162d53287ab439bcdc8cf2049e798ace1
export PREFACTOR_VERSION=2.0
export FACTOR_VERSION=1.0
export DYSCO_VERSION=22c9d4f58e13d2d92d22df036a461ea203f0697e
export LOSOTO_VERSION=9bc00c602dce58d5ade041b202c5789af3260e7b

# apt stuff
# sudo apt-get install binutils-dev bison build-essential bzip2 cmake debhelper fakeroot flex g++ gettext-base gfortran git help2man libblitz0-dev libboost-date-time${BOOST_VERSION}.0 libboost-date-time${BOOST_VERSION}-dev libboost-dev libboost-filesystem${BOOST_VERSION}.0 libboost-filesystem${BOOST_VERSION}-dev libboost-program-options${BOOST_VERSION}.0 libboost-program-options${BOOST_VERSION}-dev libboost-python${BOOST_VERSION}.0 libboost-python-dev libboost-regex${BOOST_VERSION} libboost-regex${BOOST_VERSION}.0 libboost-signals${BOOST_VERSION}.0 libboost-signals${BOOST_VERSION}-dev libboost-system${BOOST_VERSION}-dev libboost-system-dev libboost-thread${BOOST_VERSION}.0 libboost-thread${BOOST_VERSION}-dev libboost-thread-dev libcfitsio3-dev libcfitsio-bin libcfitsio-dev libfftw3-bin libfftw3-dev libgsl2 libgsl-dev libhdf5-10 libhdf5-dev liblog4cplus-1.1-9 liblog4cplus-dev libnspr4 libnspr4-dev libnss3 libnss3-dev libopenblas-base libopenblas-dev libpng12-0 libpng12-dev libpython${PYTHON_VERSION} libsasl2-dev libsigc++-2.0-dev libsslcommon2-dev libtool libunittest++-dev libuuid1 libwcs5 libxerces-c-dev libxml2 libxml++2.6-2v5 libxml++2.6-dev libxml2-dev libxqilla-dev make nano openssh-client pkg-config python${PYTHON_VERSION} python-dev python-matplotlib python-pip python-scipy python-setuptools python-xmlrunner rsync ruby ruby-dev sasl2-bin slurm-client subversion sudo swig uuid-dev wcslib-dev wget xqilla libgeos-dev

# sudo pip install numpy pyfits pywcs python-monetdb Jinja2 shapely aplpy pp matplotlib

read 
#*******************
# setup install dir
#*******************

mkdir -p ${INSTALLDIR}

# *******************
#   Casacore
# *******************

mkdir -p ${INSTALLDIR}/casacore/build 
mkdir -p ${INSTALLDIR}/casacore/data 
cd ${INSTALLDIR}/casacore && git clone https://github.com/casacore/casacore.git src 
if [ "${CASACORE_VERSION}" != "latest" ]; then cd ${INSTALLDIR}/casacore/src && git checkout tags/v${CASACORE_VERSION}; fi 
cd ${INSTALLDIR}/casacore/data && wget --retry-connrefused ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar 
cd ${INSTALLDIR}/casacore/data && tar xf WSRT_Measures.ztar  && rm -f WSRT_Measures.ztar 
cd ${INSTALLDIR}/casacore/ && wget ftp://ftp.atnf.csiro.au/pub/software/asap/data/asap_data.tar.bz2 
cd ${INSTALLDIR}/casacore/ && tar xf asap_data.tar.bz2 && rm -f asap_data.tar.bz2
cd ${INSTALLDIR}/casacore/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casacore/ -DDATA_DIR=${INSTALLDIR}/casacore/data -DBUILD_PYTHON=True -DENABLE_TABLELOCKING=ON -DUSE_OPENMP=ON -DUSE_FFTW3=TRUE -DUSE_HDF5=ON -DCXX11=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-fsigned-char -O2 -DNDEBUG -march=native" ../src/ 
cd ${INSTALLDIR}/casacore/build && make  -j
cd ${INSTALLDIR}/casacore/build && make install 
bash -c "rm -rf ${INSTALLDIR}/casacore/{build,src}" 

# *******************
#   Casarest
# *******************

mkdir -p ${INSTALLDIR}/casarest/build 
cd ${INSTALLDIR}/casarest && git clone https://github.com/casacore/casarest.git src 
if [ "${CASAREST_VERSION}" != "latest" ]; then cd ${INSTALLDIR}/casarest/src && git checkout tags/v${CASAREST_VERSION}; fi 
cd ${INSTALLDIR}/casarest/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casarest -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-std=c++11 -O2 -march=native -DNDEBUG" ../src/ 
cd ${INSTALLDIR}/casarest/build && make -j
cd ${INSTALLDIR}/casarest/build && make install 
bash -c "rm -rf ${INSTALLDIR}/casarest/{build,src}" 

# *******************
#   Pyrap
# *******************

mkdir ${INSTALLDIR}/python-casacore 
cd ${INSTALLDIR}/python-casacore && git clone https://github.com/casacore/python-casacore 
if [ "$PYTHON_CASACORE_VERSION" != "latest" ]; then cd ${INSTALLDIR}/python-casacore/python-casacore && git checkout tags/v${PYTHON_CASACORE_VERSION}; fi 
cd ${INSTALLDIR}/python-casacore/python-casacore && ./setup.py build_ext -I${INSTALLDIR}/casacore/include/ -L${INSTALLDIR}/casacore/lib/ 
mkdir -p ${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages/ 
mkdir -p ${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages/ 
export PYTHONPATH=${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages:${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages:$PYTHONPATH && cd ${INSTALLDIR}/python-casacore/python-casacore && ./setup.py install --prefix=${INSTALLDIR}/python-casacore/ 
bash -c "rm -rf ${INSTALLDIR}/python-casacore/python-casacore" 

# *******************
#   QPID client
# *******************

# Install
# QPID daemon legacy store would require: libaio-dev libdb5.1++-dev
mkdir /${INSTALLDIR}/qpid 
svn --non-interactive -q co https://svn.astron.nl/LOFAR/branches/LOFAR-Release-2_18/LCS/MessageBus/qpid/ /${INSTALLDIR}//qpid
/${INSTALLDIR}/qpid/local/sbin/build_qpid 

# *******************
#   DAL
# *******************

mkdir ${INSTALLDIR}/DAL 
cd ${INSTALLDIR}/DAL && git clone https://github.com/nextgen-astrodata/DAL.git src 
mkdir ${INSTALLDIR}/DAL/build && cd ${INSTALLDIR}/DAL/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/DAL ../src 
make -j
make install 
bash -c "rm -rf ${INSTALLDIR}/DAL/{src,build}" 

# *******************
#   AOFlagger
# *******************

mkdir -p ${INSTALLDIR}/aoflagger/build 
bash -c "cd ${INSTALLDIR}/aoflagger && wget --retry-connrefused http://downloads.sourceforge.net/project/aoflagger/aoflagger-${AOFLAGGER_VERSION%%.?}.0/aoflagger-${AOFLAGGER_VERSION}.tar.bz2" 
cd ${INSTALLDIR}/aoflagger && tar xf aoflagger-${AOFLAGGER_VERSION}.tar.bz2 
cd ${INSTALLDIR}/aoflagger/build && cmake -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DBUILD_SHARED_LIBS=ON -DCMAKE_CXX_FLAGS="--std=c++11 -O2 -DNDEBUG" -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/aoflagger ../aoflagger-${AOFLAGGER_VERSION} 
cd ${INSTALLDIR}/aoflagger/build && make -j  
cd ${INSTALLDIR}/aoflagger/build && make install 
bash -c "rm -rf ${INSTALLDIR}/aoflagger/{build,aoflagger-${AOFLAGGER_VERSION}}" 
bash -c "rm -rf ${INSTALLDIR}/aoflagger/aoflagger-${AOFLAGGER_VERSION}.tar.bz2" 

# *******************
#   LOFAR
# *******************

# Install
mkdir -p ${INSTALLDIR}/lofar/build/${LOFAR_BUILDVARIANT} 
cd ${INSTALLDIR}/lofar 
#svn --non-interactive -q co -r 35323 -N https://svn.astron.nl/LOFAR/branches/LOFAR-Release-2_18 src;
#svn --non-interactive -q --ignore-externals co -r 35694 -N https://svn.astron.nl/LOFAR/trunk src; # cxx11 compiler fix implemented in the trunk, not current branches
svn --non-interactive -q --ignore-externals co -r 35877 -N https://svn.astron.nl/LOFAR/trunk src; # cxx11 compiler fix implemented in the trunk, not current branches
svn --non-interactive -q up src/CMake 
#cd ${INSTALLDIR}/lofar/build/${LOFAR_BUILDVARIANT} && cmake -DBUILD_PACKAGES=Offline -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofar/ -DCASAREST_ROOT_DIR=${INSTALLDIR}/casarest/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DAOFLAGGER_ROOT_DIR=${INSTALLDIR}/aoflagger/ -DQPID_ROOT_DIR=/opt/qpid/ -DUSE_OPENMP=True ${INSTALLDIR}/lofar/src/
cd ${INSTALLDIR}/lofar/build/${LOFAR_BUILDVARIANT} && cmake -DBUILD_PACKAGES="Offline"  -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofar/ -DCASAREST_ROOT_DIR=${INSTALLDIR}/casarest/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DCASA_ROOT_DIR=${INSTALLDIR}/casacore/ -DBOOST_ROOT_DIR=${INSTALLDIR}/boost_1_58_0/ -DLINK_DIRECTORIES=${INSTALLDIR}/boost_1_58_0/stage/lib -DAOFLAGGER_ROOT_DIR=${INSTALLDIR}/aoflagger/ -DUSE_OPENMP=True ${INSTALLDIR}/lofar/src/ -DMAKE_AOFlagger=OFF # Modified to build the AO flagger as an external component with the latest tools as per the wiki build instructions
cd ${INSTALLDIR}/lofar/build/${LOFAR_BUILDVARIANT} && sed -i '29,31d' include/ApplCommon/PosixTime.h 
cd ${INSTALLDIR}/lofar/build/${LOFAR_BUILDVARIANT} && make -j 4
cd ${INSTALLDIR}/lofar/build/${LOFAR_BUILDVARIANT} && make install 
bash -c "mkdir -p ${INSTALLDIR}/lofar/var/{log,run}" 
bash -c "chmod a+rwx  ${INSTALLDIR}/lofar/var/{log,run}" 
bash -c "rm -rf ${INSTALLDIR}/lofar/{build,src}" 

#********************
# wsclean
#********************

# Note: install with LOFAR station response correction
# Note: set CPATH as otherwise, if compiled with LOFAR support, in LOFAR header files 
include <measures/Measures/MeasFrame.h> from casacore is unknown
export CPATH=${INSTALLDIR}/casacore/include/casacore:$CPATH 
mkdir -p ${INSTALLDIR}/wsclean/build 
cd ${INSTALLDIR}/wsclean 
wget http://downloads.sourceforge.net/project/wsclean/wsclean-${WSCLEAN_VERSION}/wsclean-${WSCLEAN_VERSION}.tar.bz2 
tar xf wsclean-${WSCLEAN_VERSION}.tar.bz2 
cd build 
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/wsclean -DCMAKE_PREFIX_PATH="${INSTALLDIR}/lofar;${INSTALLDIR}/casacore;${CFITSIO_ROOT_DIR}" -DCASA_INCLUDE_DIR=${INSTALLDIR}/casacore -DBUILD_SHARED_LIBS=TRUE ../wsclean-${WSCLEAN_VERSION}
make -j 
make install 
rm ${INSTALLDIR}/wsclean/wsclean-${WSCLEAN_VERSION}.tar.bz2 

# *******************
#   LSMTool
# *******************
 
cd ${INSTALLDIR} && git clone https://github.com/darafferty/LSMTool.git 
if [ "$LSMTOOL_VERSION" != "latest" ]; then cd ${INSTALLDIR}/LSMTool && git checkout ${LSMTOOL_VERSION}; fi # Check out specific commit
cd ${INSTALLDIR}/LSMTool && python setup.py install

# *******************
#   pyds9
# *******************

cd ${INSTALLDIR} && git clone https://github.com/ericmandel/pyds9.git
if [ "$PYDS9_VERSION" != "latest" ]; then cd ${INSTALLDIR}/pyds9 && git checkout tags/v${PYDS9_VERSION}; fi 
cd ${INSTALLDIR}/pyds9 && python setup.py install

# *******************
#   RMExtract
# *******************

cd ${INSTALLDIR} && git clone https://github.com/maaijke/RMextract.git
if [ "$RMEXTRACT_VERSION" != "latest" ]; then cd ${INSTALLDIR}/RMextract && git checkout ${RMEXTRACT_VERSION}; fi # Check out specific commit 
cd ${INSTALLDIR}/RMextract && python setup.py install --add-lofar-utils

# *******************
#   LoSoTo
# *******************

cd ${INSTALLDIR} && git clone https://github.com/revoltek/losoto.git
if [ "$LOSOTO_VERSION" != "latest" ]; then cd ${INSTALLDIR}/losoto && git checkout v${LOSOTO_VERSION}; fi # Check out specific commit
d ${INSTALLDIR}/losoto
python setup.py install --prefix=${INSTALLDIR}

# *******************
#   Prefactor
# *******************

cd ${INSTALLDIR} && git clone https://github.com/lofar-astron/prefactor.git
if [ "$PREFACTOR_VERSION" != "latest" ]; then cd ${INSTALLDIR}/prefactor && git checkout tags/v${PREFACTOR_VERSION}; fi

# *******************
#   Factor
# *******************

cd ${INSTALLDIR} && git clone https://github.com/lofar-astron/factor.git
if [ "$FACTOR_VERSION" != "latest" ]; then cd ${INSTALLDIR}/factor && git checkout tags/v${FACTOR_VERSION}; fi
cd ${INSTALLDIR}/factor && python setup.py install

# *******************
#   Dysco
# *******************

cd ${INSTALLDIR} && git clone https://github.com/aroffringa/dysco.git
if [ "$DYSCO_VERSION" != "latest" ]; then cd ${INSTALLDIR}/dysco && git checkout ${DYSCO_VERSION}; fi # Check out specific commit
cd ${INSTALLDIR}/dysco
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofar/ -DCASAREST_ROOT_DIR=${INSTALLDIR}/casarest/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DCASA_ROOT_DIR=${INSTALLDIR}/casacore/ ../
ake -j 4
make install
bash -c "rm -rf ${INSTALLDIR}/dysco/build" 

#********************
# CASA measures
#********************

cd ${INSTALLDIR}/casacore/data
wget ftp://ftp.atnf.csiro.au/pub/software/asap/data/asap_data.tar.bz2 && tar -xjvf asap_data.tar.bz2

