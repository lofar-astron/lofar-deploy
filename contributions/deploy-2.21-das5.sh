#
# common-environment
#
export USER=grange
export INSTALLDIR=/var/scratch/grange/lofar_install/opt
export BUILDDIR=/var/scratch/grange/lofar_install/build
#
# environment
#
export PYTHON_VERSION=2.7

#
# versions
#
# Versions of software to build
export CFITSIO_VERSION=3410
export WCSLIB_VERSION=5.16
export LOG4CPLUS_VERSION=1.1.x
export CASACORE_VERSION=v2.3.0
export CASAREST_VERSION=v1.4.2
export PYTHON_CASACORE_VERSION=v2.1.2
export PYBDSF_VERSION=v1.8.11
export AOFLAGGER_VERSION=v2.8.0
export LOFAR_VERSION=2_21_4
export WSCLEAN_VERSION=2.4

# Versions of modules to load
export LOG4CPLUS_VERSION=1.1.x
export GCC_VERSION=4.9.3
export BOOST_VERSION=1.60.0
export HDF5_VERSION=1.8.17
export BLAS_VERSION=0.2.17
export LAPACK_VERSION=3.6.0
export FFTW_VERSION=3.3.4
export GSL_VERSION=1.15
export XMLRUNNER_VERSION=1.7.7
export MONETDB_VERSION=11.19.3.2
export UNITTEST2_VERSION=1.1.0
export PYFITS_VERSION=3.3
export PYWCS_VERSION=1.12

#
# base
#
echo `date` "Started base"
# yum -y remove iputils
# yum -y update
# yum -y install sudo
# yum -y install git svn wget 
# yum -y install automake-devel aclocal autoconf autotools cmake make
# yum -y install g++ gcc gcc-c++ gcc-gfortran
# yum -y install blas-devel boost-devel fftw3-devel fftw3-libs python-devel lapack-devel libpng-devel libxml2-devel numpy-devel readline-devel ncurses-devel f2py bzip2-devel libicu-devel scipy
# yum -y install bison flex ncurses tar bzip2 which gettext
# wget --retry-connrefused https://bootstrap.pypa.io/get-pip.py -O - | python
# pip install pyfits pywcs python-monetdb xmlrunner unittest2
# echo `date` "Completed base"

( # sub shell, adding exta paren for vim syntax highlighting to work) 
set -e # kill shell if step fails
set -x # debug mode

# Several dependencies are already present as modules so we just load them in stead of a clean build.
module load gcc/${GCC_VERSION}

module load boost/${BOOST_VERSION}
module load hdf5/${HDF5_VERSION}
module load openblas/${BLAS_VERSION}mt
module load lapack/${LAPACK_VERSION}-gcc-${GCC_VERSION}
module load fftw/${FFTW_VERSION}-gcc-${GCC_VERSION}
module load gsl/${GSL_VERSION}-gcc-${GCC_VERSION}
module load log4cplus/${LOG4CPLUS_VERSION}-gcc-${GCC_VERSION}
module load xmlrunner/${XMLRUNNER_VERSION}
module load python-monetdb/${MONETDB_VERSION}
module load unittest2/${UNITTEST2_VERSION}
module load pyfits/${PYFITS_VERSION}
module load pywcs/${PYWCS_VERSION}


# Note: everything is installed under "root_dir"/"version"/"installation_name";
# packages are made available as "lib_name"[/"installation_name"]/"version"
# to match the bright cluster manager naming convention
INSTALLNAME=gcc-${GCC_VERSION}
export CFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/${CFITSIO_VERSION}-${INSTALLNAME}
export WCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib/${WCSLIB_VERSION}-${INSTALLNAME}
export CASACORE_ROOT_DIR=${INSTALLDIR}/casacore/${CASACORE_VERSION}-${INSTALLNAME}
export PYTHON_CASACORE_ROOT_DIR=${INSTALLDIR}/python-casacore/${PYTHON_CASACORE_VERSION}
export CASAREST_ROOT_DIR=${INSTALLDIR}/casarest/${CASAREST_VERSION}-${INSTALLNAME}
export AOFLAGGER_ROOT_DIR=${INSTALLDIR}/aoflagger/${AOFLAGGER_VERSION}-${INSTALLNAME}
LOFAR_VERSION_FOLDER=${LOFAR_VERSION//_/.}
export WSCLEAN_ROOT_DIR=${INSTALLDIR}/wsclean/${WSCLEAN_VERSION}-${INSTALLNAME}
export LOFAR_ROOT_DIR=${INSTALLDIR}/lofar/${LOFAR_VERSION_FOLDER}-${INSTALLNAME}
export PYBDSF_ROOT_DIR=${INSTALLDIR}/pybdsf/${PYBDSF_VERSION}

# build directories
export CFITSIO_BUILD_DIR=${BUILDDIR}/cfitsio/${CFITSIO_VERSION}-${INSTALLNAME}
export WCSLIB_BUILD_DIR=${BUILDDIR}/wcslib/${WCSLIB_VERSION}-${INSTALLNAME}
export CASACORE_BUILD_DIR=${BUILDDIR}/casacore/${CASACORE_VERSION}-${INSTALLNAME}
export PYTHON_CASACORE_BUILD_DIR=${BUILDDIR}/python-casacore/${PYTHON_CASACORE_VERSION}
export CASAREST_BUILD_DIR=${BUILDDIR}/casarest/${CASAREST_VERSION}-${INSTALLNAME}
export AOFLAGGER_BUILD_DIR=${BUILDDIR}/aoflagger/${AOFLAGGER_VERSION}-${INSTALLNAME}
LOFAR_VERSION_FOLDER=${LOFAR_VERSION//_/.}
export WSCLEAN_BUILD_DIR=${BUILDDIR}/wsclean/${WSCLEAN_VERSION}-${INSTALLNAME}
export LOFAR_BUILD_DIR=${BUILDDIR}/lofar/${LOFAR_VERSION_FOLDER}-${INSTALLNAME}
export PYBDSF_BUILD_DIR=${BUILDDIR}/pybdsf/${PYBDSF_VERSION}


#
# install-cfitsio
#
echo `date` "Started install-cfitsio"
mkdir -p ${CFITSIO_BUILD_DIR}/build
cd ${CFITSIO_BUILD_DIR} && wget --retry-connrefused ftp://anonymous@heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio${CFITSIO_VERSION}.tar.gz
cd ${CFITSIO_BUILD_DIR} && tar xf cfitsio${CFITSIO_VERSION}.tar.gz
cd ${CFITSIO_BUILD_DIR}/build && cmake -DCMAKE_INSTALL_PREFIX=${CFITSIO_ROOT_DIR} ../cfitsio
cd ${CFITSIO_BUILD_DIR}/build && make -j 
cd ${CFITSIO_BUILD_DIR}/build && make install
echo `date` "Completed install-cfitsio"

#
# install-wcslib
#
echo `date` "Started install-wcslib"
mkdir -p ${WCSLIB_BUILD_DIR}
if [ "${WCSLIB_VERSION}" = "latest" ]; then cd ${WCSLIB_BUILD_DIR} && wget --retry-connrefused ftp://anonymous@ftp.atnf.csiro.au/pub/software/wcslib/wcslib.tar.bz2 -O wcslib-latest.tar.bz2; fi
if [ "${WCSLIB_VERSION}" != "latest" ]; then cd ${WCSLIB_BUILD_DIR} && wget --retry-connrefused ftp://anonymous@ftp.atnf.csiro.au/pub/software/wcslib/wcslib-${WCSLIB_VERSION}.tar.bz2; fi
cd ${WCSLIB_BUILD_DIR} && tar xf wcslib-*.tar.bz2
cd ${WCSLIB_BUILD_DIR}/wcslib* && ./configure --prefix=${WCSLIB_ROOT_DIR} --with-cfitsiolib=${CFITSIO_ROOT_DIR}/lib/ --with-cfitsioinc=${CFITSIO_ROOT_DIR}/include/ --without-pgplot
cd ${WCSLIB_BUILD_DIR}/wcslib* && make
cd ${WCSLIB_BUILD_DIR}/wcslib* && make install
echo `date` "Completed install-wcslib"

#
# install-casacore
#
echo `date` "Started install-casacore"
mkdir -p ${CASACORE_BUILD_DIR}/build
mkdir -p ${CASACORE_ROOT_DIR}/data
cd ${CASACORE_BUILD_DIR} && git clone https://github.com/casacore/casacore.git src
if [ "${CASACORE_VERSION}" != "latest" ]; then cd ${CASACORE_BUILD_DIR}/src && git checkout tags/${CASACORE_VERSION}; fi
cd ${CASACORE_ROOT_DIR}/data && wget --retry-connrefused ftp://anonymous@ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
cd ${CASACORE_ROOT_DIR}/data && tar xf WSRT_Measures.ztar
cd ${CASACORE_BUILD_DIR}/build && cmake -DCMAKE_INSTALL_PREFIX=${CASACORE_ROOT_DIR}/ -DDATA_DIR=${CASACORE_ROOT_DIR}/data -DWCSLIB_ROOT_DIR=/${WCSLIB_ROOT_DIR}/ -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR}/ -DBUILD_PYTHON=True -DUSE_OPENMP=True -DUSE_FFTW3=TRUE ../src/
cd ${CASACORE_BUILD_DIR}/build && make -j 
cd ${CASACORE_BUILD_DIR}/build && make install
echo `date` "Completed install-casacore"

#
# install-casarest
#
echo `date` "Started install-casarest"
mkdir -p ${CASAREST_BUILD_DIR}/build
cd ${CASAREST_BUILD_DIR} && git clone https://github.com/casacore/casarest.git src
if [ "${CASAREST_VERSION}" != "latest" ]; then cd ${CASAREST_BUILD_DIR}/src && git checkout tags/${CASAREST_VERSION}; fi
cd ${CASAREST_BUILD_DIR}/build && cmake -DCMAKE_INSTALL_PREFIX=${CASAREST_ROOT_DIR} -DCASACORE_ROOT_DIR=${CASACORE_ROOT_DIR} -DWCSLIB_ROOT_DIR=${WCSLIB_ROOT_DIR} -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR} ../src/
cd ${CASAREST_BUILD_DIR}/build && make -j 
cd ${CASAREST_BUILD_DIR}/build && make install
echo `date` "Completed install-casarest"

#
# install-python-casacore
#
echo `date` "Started install-python-casacore"
mkdir -p ${PYTHON_CASACORE_BUILD_DIR}
cd ${PYTHON_CASACORE_BUILD_DIR} && git clone https://github.com/casacore/python-casacore
if [ "$PYTHON_CASACORE_VERSION" != "latest" ]; then cd ${PYTHON_CASACORE_BUILD_DIR}/python-casacore && git checkout tags/${PYTHON_CASACORE_VERSION}; fi
cd ${PYTHON_CASACORE_BUILD_DIR}/python-casacore && ./setup.py build_ext -I${WCSLIB_ROOT_DIR}/include:${CASACORE_ROOT_DIR}/include/:${CFITSIO_ROOT_DIR}/include -L${WCSLIB_ROOT_DIR}/lib:${CASACORE_ROOT_DIR}/lib/:${CFITSIO_ROOT_DIR}/lib/ -R${WCSLIB_ROOT_DIR}/lib:${CASACORE_ROOT_DIR}/lib/:${CFITSIO_ROOT_DIR}/lib/
mkdir -p ${PYTHON_CASACORE_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/
mkdir -p ${PYTHON_CASACORE_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${PYTHON_CASACORE_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages:${PYTHON_CASACORE_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages:$PYTHONPATH && cd ${PYTHON_CASACORE_BUILD_DIR}/python-casacore && ./setup.py develop --prefix=${PYTHON_CASACORE_ROOT_DIR}/
echo `date` "Completed install-python-casacore"

#
# install-pybdsf
#
echo `date` "Started install-pybdsf"
mkdir -p ${PYBDSF_BUILD_DIR}
cd ${PYBDSF_BUILD_DIR} && git clone https://github.com/lofar-astron/pybdsf
if [ "$PYBDSF_VERSION" != "latest" ]; then cd ${PYBDSF_BUILD_DIR}/pybdsf && git checkout tags/${PYBDSF_VERSION}; fi
mkdir -p ${PYBDSF_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/
mkdir -p ${PYBDSF_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${PYBDSF_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages:${PYBDSF_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages:$PYTHONPATH && cd ${PYBDSF_BUILD_DIR}/pybdsf && ./setup.py develop --prefix=${PYBDSF_ROOT_DIR}/
echo `date` "Completed install-pybdsf"

#
# install-aoflagger
#
echo `date` "Started install-aoflagger"
mkdir -p ${AOFLAGGER_BUILD_DIR}/build
cd ${AOFLAGGER_BUILD_DIR} && git clone git://git.code.sf.net/p/aoflagger/code aoflagger
cd ${AOFLAGGER_BUILD_DIR}/aoflagger && git checkout tags/${AOFLAGGER_VERSION}
cd ${AOFLAGGER_BUILD_DIR}/build && cmake -DCMAKE_INSTALL_PREFIX=${AOFLAGGER_ROOT_DIR}/ -DCASACORE_ROOT_DIR=${CASACORE_ROOT_DIR} -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR} -DBUILD_SHARED_LIBS=ON ../aoflagger
cd ${AOFLAGGER_BUILD_DIR}/build && make -j 
cd ${AOFLAGGER_BUILD_DIR}/build && make install
echo `date` "Completed install-aoflagger"

#
# install-lofar
#
echo `date` "Started install-lofar"
mkdir -p ${LOFAR_BUILD_DIR}/build/gnu_opt
if [ "${LOFAR_VERSION}" = "latest" ]; then cd ${LOFAR_BUILD_DIR} && svn --non-interactive -q co https://svn.astron.nl/LOFAR/trunk src; fi
if [ "${LOFAR_VERSION}" != "latest" ]; then cd ${LOFAR_BUILD_DIR} && svn --non-interactive -q co https://svn.astron.nl/LOFAR/tags/LOFAR-Release-${LOFAR_VERSION} src; fi
sed -i.bak 's+/usr/bin/++g' ${LOFAR_BUILD_DIR}/src/CMake/variants/GNU.cmake 
cd ${LOFAR_BUILD_DIR}/build/gnu_opt && cmake -DBUILD_PACKAGES=Offline -DCMAKE_INSTALL_PREFIX=${LOFAR_ROOT_DIR}/ -DWCSLIB_ROOT_DIR=${WCSLIB_ROOT_DIR}/ -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR}/ -DCASAREST_ROOT_DIR=${CASAREST_ROOT_DIR}/ -DCASACORE_ROOT_DIR=${CASACORE_ROOT_DIR}/ -DLOG4CPLUS_ROOT_DIR=${LOG4CPLUS_ROOT_DIR} -DPYTHON_BDSF=${PYBDSF_ROOT_DIR} -DAOFLAGGER_ROOT_DIR=${AOFLAGGER_ROOT_DIR}/ -DUSE_OPENMP=True ${LOFAR_BUILD_DIR}/src/
cd ${LOFAR_BUILD_DIR}/build/gnu_opt && make -j 
cd ${LOFAR_BUILD_DIR}/build/gnu_opt && make install
echo `date` "Completed install-lofar"

#
# install-wsclean
#
echo `date` "Started install-wsclean"
CPATH=${CASACORE_ROOT_DIR}/include/casacore:$CPATH
mkdir -p ${WSCLEAN_BUILD_DIR}/build
cd ${WSCLEAN_BUILD_DIR}
wget http://downloads.sourceforge.net/project/wsclean/wsclean-${WSCLEAN_VERSION}/wsclean-${WSCLEAN_VERSION}.tar.bz2
tar xf wsclean-${WSCLEAN_VERSION}.tar.bz2
cd build
cmake -DCMAKE_INSTALL_PREFIX=${WSCLEAN_ROOT_DIR} -DCMAKE_PREFIX_PATH="${LOFAR_ROOT_DIR};${CASACORE_ROOT_DIR};${CFITSIO_ROOT_DIR}" -DBUILD_SHARED_LIBS=TRUE ../wsclean-${WSCLEAN_VERSION}
make -j 
make install
echo `date` "Completed install-wsclean"
)

