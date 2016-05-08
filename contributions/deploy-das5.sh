# common-environment
export INSTALLDIR=/var/scratch/${USER}/opt

# number of threads used by make
export J=56


########## set which packages to install from source ##########

# set which packages to install

# for the following the default is 'false'
INSTALL_GCC=false
INSTALL_BLAS=false
INSTALL_LAPACK=false
INSTALL_FFTW=false
INSTALL_BOOST=false
INSTALL_HDF5=false

# for the following the default is 'true'
INSTALL_GSL=true
INSTALL_PYFITS=true
INSTALL_PYWCS=true
INSTALL_PYMONETDB=true
INSTALL_XMLRUNNER=true
INSTALL_UNITTEST2=true
INSTALL_CFITSIO=true
INSTALL_WCSLIB=true
INSTALL_LOG4CPLUS=true
INSTALL_CASACORE=true
INSTALL_CASAREST=true
INSTALL_PYTHON_CASACORE=true
INSTALL_AOFLAGGER=true
INSTALL_LOFAR=true
INSTALL_WSCLEAN=true


########## set package version (if install)  ##########

# versions
# Note: for wcslib version 5.14, 45 casacore test fail => use 5.13
# Note: das5 needs GSL version 1.15, otherwise installation of GSL confused
export PYTHON_VERSION=2.7
export GCC_VERSION=4.9.3
export OPENBLAS_VERSION=0.2.17
export LAPACK_VERSION=3.6.0
export FFTW_VERSION=3.3.4
export GSL_VERSION=1.15
export PYFITS_VERSION=3.3
export PYWCS_VERSION=1.12
export PYMONETDB_VERSION=11.19.3.2
export XMLRUNNER_VERSION=1.7.7
export UNITTEST2_VERSION=1.1.0
export CFITSIO_VERSION=3380
export WCSLIB_VERSION=5.13
export LOG4CPLUS_VERSION=1.1.x
export CASACORE_VERSION=v2.1.0
export CASAREST_VERSION=v1.4.1
export PYTHON_CASACORE_VERSION=v2.1.0
export AOFLAGGER_VERSION=v2.7.0
export LOFAR_VERSION=2_16_0
export WSCLEAN_VERSION=1.9


########## set install directories ##########

# Note: everything is installed under "root_dir"/"version"/"installation_name";
# packages are made available as "lib_name"[/"installation_name"]/"version"
# to match the bright cluster manager naming convention
INSTALLNAME=gcc-${GCC_VERSION}
export BLAS_ROOT_DIR=${INSTALLDIR}/openblas/${OPENBLAS_VERSION}mt
export LAPACK_ROOT_DIR=${INSTALLDIR}/lapack/${LAPACK_VERSION}-${INSTALLNAME}
export FFTW3_ROOT_DIR=${INSTALLDIR}/fftw/${FFTW_VERSION}-${INSTALLNAME}
export LOG4CPLUS_ROOT_DIR=${INSTALLDIR}/log4cplus/${LOG4CPLUS_VERSION}-${INSTALLNAME}
export GSL_ROOT_DIR=${INSTALLDIR}/gsl/${GSL_VERSION}-${INSTALLNAME}
export PYFITS_ROOT_DIR=${INSTALLDIR}/pyfits/${PYFITS_VERSION}
export PYWCS_ROOT_DIR=${INSTALLDIR}/pywcs/${PYWCS_VERSION}
export PYMONETDB_ROOT_DIR=${INSTALLDIR}/python-monetdb/${PYMONETDB_VERSION}
export XMLRUNNER_ROOT_DIR=${INSTALLDIR}/xmlrunner/${XMLRUNNER_VERSION}
export UNITTEST2_ROOT_DIR=${INSTALLDIR}/unittest2/${UNITTEST2_VERSION}
export CFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/${CFITSIO_VERSION}-${INSTALLNAME}
export WCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib/${WCSLIB_VERSION}-${INSTALLNAME}
export CASACORE_ROOT_DIR=${INSTALLDIR}/casacore/${CASACORE_VERSION}-${INSTALLNAME}
export PYTHON_CASACORE_ROOT_DIR=${INSTALLDIR}/python-casacore/${PYTHON_CASACORE_VERSION}
export CASAREST_ROOT_DIR=${INSTALLDIR}/casarest/${CASAREST_VERSION}-${INSTALLNAME}
export AOFLAGGER_ROOT_DIR=${INSTALLDIR}/aoflagger/${AOFLAGGER_VERSION}-${INSTALLNAME}
LOFAR_VERSION_FOLDER=${LOFAR_VERSION//_/.}
export WSCLEAN_ROOT_DIR=${INSTALLDIR}/wsclean/${WSCLEAN_VERSION}-${INSTALLNAME}
export LOFAR_ROOT_DIR=${INSTALLDIR}/lofar/${LOFAR_VERSION_FOLDER}-${INSTALLNAME}




#########################################################
############### IDEA IS TO NOT EDIT BELOW ###############
#########################################################


# install gcc
if ( $INSTALL_GCC ); then
echo "Installing GCC from source not supported yet."
echo "Loading GCC module"
module load gcc/${GCC_VERSION}
else
echo "Loading GCC module"
module load gcc/${GCC_VERSION}
fi


# install blas
# Note creates symlinks named 'libblas' as cmake does not
# recognize openblas otheriwse at the moment
if ( $INSTALL_BLAS ); then
mkdir -p ${BLAS_ROOT_DIR}
cd ${BLAS_ROOT_DIR}
wget http://github.com/xianyi/OpenBLAS/archive/v${OPENBLAS_VERSION}.tar.gz
tar xf v${OPENBLAS_VERSION}.tar.gz
cd OpenBLAS-${OPENBLAS_VERSION}
make -j ${J}
make PREFIX=${BLAS_ROOT_DIR} install
ln -s ${BLAS_ROOT_DIR}/lib/libopenblas.a ${BLAS_ROOT_DIR}/lib/libblas.a
ln -s ${BLAS_ROOT_DIR}/lib/libopenblas.so ${BLAS_ROOT_DIR}/lib/libblas.so
else
echo "Loading OpenBLAS module, version 0.2.17"
module load openblas/0.2.17mt
fi


# install lapack
if ( $INSTALL_LAPACK ); then
echo `date` "Started install-lapack"
mkdir -p ${LAPACK_ROOT_DIR}/build
cd ${LAPACK_ROOT_DIR}
wget http://www.netlib.org/lapack/lapack-${LAPACK_VERSION}.tgz
tar xf lapack-${LAPACK_VERSION}.tgz
cd build
cmake -DCMAKE_PREFIX_PATH=${BLAS_ROOT_DIR} -DCMAKE_INSTALL_PREFIX=${LAPACK_ROOT_DIR} -DUSE_OPTIMIZED_BLAS=TRUE -DBUILD_SHARED_LIBS=TRUE ../lapack-${LAPACK_VERSION}
make -j ${J}
make install
echo `date` "Completed install-lapack"
else
echo "Loading LAPACK module, version 3.6.0"
module load lapack/3.6.0-gcc-${GCC_VERSION}
fi


if ( $INSTALL_FFTW ); then
echo `date` "Started install-fftw3"
mkdir -p ${FFTW3_ROOT_DIR}
cd ${FFTW3_ROOT_DIR}
wget http://www.fftw.org/fftw-${FFTW_VERSION}.tar.gz
tar xf fftw-${FFTW_VERSION}.tar.gz
cd fftw-${FFTW_VERSION}
# Install single precision
./configure --enable-shared --enable-float --enable-openmp --enable-threads --enable-avx --enable-fma --prefix=${FFTW3_ROOT_DIR}
make -j $J install
# Install double precision
./configure --enable-shared --enable-openmp --enable-threads --enable-avx --enable-fma --prefix=${FFTW3_ROOT_DIR}
make -j $J install
# Install long precision
./configure --enable-shared --enable-openmp --enable-threads --enable-long-double --enable-fma --prefix=${FFTW3_ROOT_DIR}
make -j $J install
echo `date` "Completed install-fftw3"
else
echo "Loading FFTW module, version 3.3.4"
module load fftw/3.3.4-gcc-${GCC_VERSION}
fi


# install boost
if ( $INSTALL_BOOST ); then
echo "Installing BOOST from source not supported yet."
echo "Loading BOOST module, version 1.60.0"
# define BOOST_ROOT
module load boost/1.60.0
# Correcting boost include
BOOST_INCLUDE=${BOOST_ROOT}/include
else
echo "Loading BOOST module, version 1.60.0"
# define BOOST_ROOT
module load boost/1.60.0
# Correcting boost include
BOOST_INCLUDE=${BOOST_ROOT}/include
fi


# install hdf5
if ( $INSTALL_HDF5 ); then
echo "Installing HDF5 from source not supported yet."
echo "Loading HDF5 module, version 1.6.10"
# load HDF5 for automatic detection
module load hdf5/1.6.10
else
# load HDF5 for automatic detection
module load hdf5/1.6.10
fi


# install log4cplus (for LOFAR)
if ( $INSTALL_LOG4CPLUS ); then
echo `date` "Started install-log4cplus"
mkdir -p ${LOG4CPLUS_ROOT_DIR}/build
cd ${LOG4CPLUS_ROOT_DIR}
git clone https://github.com/log4cplus/log4cplus.git -b ${LOG4CPLUS_VERSION} src
cd build
cmake -DCMAKE_INSTALL_PREFIX=${LOG4CPLUS_ROOT_DIR} ../src
make -j ${J}
make install
echo `date` "Completed install-log4cplus"
fi


# install GSL (for aoflagger)
if ( $INSTALL_GSL ); then
echo `date` "Started install-gsl"
mkdir -p ${GSL_ROOT_DIR}
cd ${GSL_ROOT_DIR}
wget http://gnu.xl-mirror.nl/gsl/gsl-${GSL_VERSION}.tar.gz
tar xf gsl-${GSL_VERSION}.tar.gz
cd gsl-${GSL_VERSION}
./configure --prefix=${GSL_ROOT_DIR}
make install
echo `date` "Completed install-gsl"
fi


#  install pyfits
if ( $INSTALL_PYFITS ); then
echo `date` "Started install-pyfits"
mkdir -p ${PYFITS_ROOT_DIR}
cd ${PYFITS_ROOT_DIR}
wget https://pypi.python.org/packages/source/p/pyfits/pyfits-${PYFITS_VERSION}.tar.gz
tar xf pyfits-${PYFITS_VERSION}.tar.gz
cd pyfits-${PYFITS_VERSION}
mkdir -p ${INSTALLDIR}/pyfits/${PYFITS_VERSION}/lib64/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${INSTALLDIR}/pyfits/${PYFITS_VERSION}/lib64/python${PYTHON_VERSION}/site-packages/:${PYTHONPATH}
python setup.py install --prefix=${INSTALLDIR}/pyfits/${PYFITS_VERSION}
echo `date` "Completed install-pyfits"
fi


# install pywcs
if ( $INSTALL_PYWCS ); then
echo `date` "Started install-pywcs"
mkdir -p ${PYWCS_ROOT_DIR}
cd ${PYWCS_ROOT_DIR}
wget https://pypi.python.org/packages/source/p/pywcs/pywcs-${PYWCS_VERSION}.tar.gz
tar xf pywcs-${PYWCS_VERSION}.tar.gz
cd pywcs-${PYWCS_VERSION}
mkdir -p ${PYWCS_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${PYWCS_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages/:${PYTHONPATH}
python setup.py install --prefix=${PYWCS_ROOT_DIR}
echo `date` "Completed install-pywcs"
fi


# install pymonetdb
if ( $INSTALL_PYMONETDB ); then
echo `date` "Started install-pymonetdb"
mkdir -p ${PYMONETDB_ROOT_DIR}
cd ${PYMONETDB_ROOT_DIR}
wget https://pypi.python.org/packages/source/p/python-monetdb/python-monetdb-${PYMONETDB_VERSION}.tar.gz
tar xf python-monetdb-${PYMONETDB_VERSION}.tar.gz
cd python-monetdb-${PYMONETDB_VERSION}
mkdir -p ${PYMONETDB_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${PYMONETDB_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/:${PYTHONPATH}
python setup.py install --prefix=${PYMONETDB_ROOT_DIR}
echo `date` "Completed install-pymonetdb"
fi


# install xmlrunner
if ( $INSTALL_XMLRUNNER ); then
echo `date` "Started install-xmlrunner"
mkdir -p ${XMLRUNNER_ROOT_DIR}
cd ${XMLRUNNER_ROOT_DIR}
wget https://pypi.python.org/packages/source/x/xmlrunner/xmlrunner-${XMLRUNNER_VERSION}.tar.gz
tar xf xmlrunner-${XMLRUNNER_VERSION}.tar.gz
cd xmlrunner-${XMLRUNNER_VERSION}
mkdir -p ${XMLRUNNER_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${XMLRUNNER_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/:${PYTHONPATH}
python setup.py install --prefix=${XMLRUNNER_ROOT_DIR}
echo `date` "Completed install-xmlrunner"
fi


# install unittest2
if ( $INSTALL_UNITTEST2 ); then
echo `date` "Started install-unittest2"
mkdir -p ${UNITTEST2_ROOT_DIR}
cd ${UNITTEST2_ROOT_DIR}
wget https://pypi.python.org/packages/source/u/unittest2/unittest2-${UNITTEST2_VERSION}.tar.gz
tar xf unittest2-${UNITTEST2_VERSION}.tar.gz
cd unittest2-${UNITTEST2_VERSION}
mkdir -p ${UNITTEST2_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${UNITTEST2_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/:${PYTHONPATH}
python setup.py install --prefix=${UNITTEST2_ROOT_DIR}
echo `date` "Completed install-unittest2"
fi


# install cfitsio
if ( $INSTALL_CFITSIO ); then
echo `date` "Started install-cfitsio"
mkdir -p ${CFITSIO_ROOT_DIR}/build
cd ${CFITSIO_ROOT_DIR}
wget --retry-connrefused ftp://anonymous@heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio${CFITSIO_VERSION}.tar.gz
tar xf cfitsio${CFITSIO_VERSION}.tar.gz
cd build
mv ../cfitsio/FindPthreads.cmake ../cfitsio/Findpthreads.cmake
cmake -DCMAKE_INSTALL_PREFIX=${CFITSIO_ROOT_DIR} ../cfitsio -DUSE_PTHREADS=1 -DCMAKE_MODULE_PATH=../cfitsio
make -j ${J}
make install
echo `date` "Completed install-cfitsio"
fi


# install-wcslib
if ( $INSTALL_WCSLIB ); then
echo `date` "Started install-wcslib"
mkdir -p ${WCSLIB_ROOT_DIR}
cd ${WCSLIB_ROOT_DIR}
wget --retry-connrefused ftp://anonymous@ftp.atnf.csiro.au/pub/software/wcslib/wcslib-${WCSLIB_VERSION}.tar.bz2
tar xf wcslib-*.tar.bz2
cd ${WCSLIB_ROOT_DIR}/wcslib*
./configure --prefix=${WCSLIB_ROOT_DIR} --with-cfitsiolib=${WCSLIB_ROOT_DIR}/lib --with-cfitsioinc=${WCSLIB_ROOT_DIR}/include --without-pgplot
make
make install
echo `date` "Completed install-wcslib"
fi


# install-casacore
# Note: using the PREFIX_PATH to find LAPACK/BLAS, as OpenBLAS is not
# detected by cmake at the moment
# Note: use c++11 for wsclean
if ( $INSTALL_CASACORE ); then
echo `date` "Started install-casacore"
mkdir -p ${CASACORE_ROOT_DIR}/build
mkdir -p ${CASACORE_ROOT_DIR}/data
cd ${CASACORE_ROOT_DIR}
git clone https://github.com/casacore/casacore.git src
cd ${CASACORE_ROOT_DIR}/src
git checkout tags/${CASACORE_VERSION}
cd ${CASACORE_ROOT_DIR}/data
wget --retry-connrefused ftp://anonymous@ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
tar xf WSRT_Measures.ztar
cd ${CASACORE_ROOT_DIR}/build
cmake -DCMAKE_INSTALL_PREFIX=${CASACORE_ROOT_DIR} -DDATA_DIR=${CASACORE_ROOT_DIR}/data -DBOOST_ROOT=${BOOST_ROOT} -DWCSLIB_ROOT_DIR=${WCSLIB_ROOT_DIR} -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR} -DBUILD_PYTHON=True -DUSE_OPENMP=True -DUSE_FFTW3=TRUE -DFFTW3_ROOT_DIR=${FFTW3_ROOT_DIR} -DCXX11=TRUE -DCMAKE_PREFIX_PATH="${LAPACK_ROOT_DIR};${BLAS_ROOT_DIR}" ../src/
make -j ${J}
make install
echo `date` "Completed install-casacore"
fi


# install-python-casacore
if ( $INSTALL_PYTHON_CASACORE ); then
echo `date` "Started install-python-casacore"
mkdir -p ${PYTHON_CASACORE_ROOT_DIR}
cd ${PYTHON_CASACORE_ROOT_DIR}
git clone https://github.com/casacore/python-casacore
cd python-casacore
./setup.py build_ext -I${WCSLIB_ROOT_DIR}/include:${CASACORE_ROOT_DIR}/include:${CFITSIO_ROOT_DIR}/include:${BOOST_INCLUDE}:/usr/include/python${PYTHON_VERSION} -L${WCSLIB_ROOT_DIR}/lib:${CASACORE_ROOT_DIR}/lib:${CFITSIO_ROOT_DIR}/lib/:${BOOST_LIB} -R${INSTALLDIR}/wcslib/${WCSLIB_VERSION}/lib:${CASACORE_ROOT_DIR}/lib:${CFITSIO_ROOT_DIR}/lib:${BOOST_LIB}
mkdir -p ${PYTHON_CASACORE_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages/
mkdir -p ${PYTHON_CASACORE_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages/
export PYTHONPATH=${PYTHON_CASACORE_ROOT_DIR}/lib/python${PYTHON_VERSION}/site-packages:${PYTHON_CASACORE_ROOT_DIR}/lib64/python${PYTHON_VERSION}/site-packages:$PYTHONPATH
./setup.py develop --prefix=${PYTHON_CASACORE_ROOT_DIR}
echo `date` "Completed install-python-casacore"
fi


# install-casarest
# Note: using the PREFIX_PATH to find LAPACK/BLAS, as OpenBLAS is not
# detected by cmake at the moment
if ( $INSTALL_CASAREST ); then
echo `date` "Started install-casarest"
mkdir -p ${CASAREST_ROOT_DIR}/build
cd ${CASAREST_ROOT_DIR}
git clone https://github.com/casacore/casarest.git src
cd build
cmake -DCMAKE_INSTALL_PREFIX=${CASAREST_ROOT_DIR} -DCASACORE_ROOT_DIR=${CASACORE_ROOT_DIR} -DWCSLIB_ROOT_DIR=${WCSLIB_ROOT_DIR} -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR} -DCMAKE_PREFIX_PATH="${LAPACK_ROOT_DIR};${BLAS_ROOT_DIR}" ../src/
make -j ${J}
make install
echo `date` "Completed install-casarest"
fi


# install-aoflagger
# Note: explictly sets BOOST_ASIO_H_FOUND to not use the header in /usr/include
if ( $INSTALL_AOFLAGGER ); then
echo `date` "Started install-aoflagger"
mkdir -p ${AOFLAGGER_ROOT_DIR}/build
cd ${AOFLAGGER_ROOT_DIR}
git clone git://git.code.sf.net/p/aoflagger/code aoflagger
cd aoflagger
git checkout tags/${AOFLAGGER_VERSION}
cd ${AOFLAGGER_ROOT_DIR}/build
cmake -DCMAKE_INSTALL_PREFIX=${AOFLAGGER_ROOT_DIR} -DCASACORE_ROOT_DIR=${CASACORE_ROOT_DIR} -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR} -DBUILD_SHARED_LIBS=ON -DCMAKE_PREFIX_PATH="${GSL_ROOT_DIR};${FFTW3_ROOT_DIR};${LAPACK_ROOT_DIR};${BLAS_ROOT_DIR}" -DBOOST_ASIO_H_FOUND=${BOOST_INCLUDE} ../aoflagger
make -j ${J}
make install
echo `date` "Completed install-aoflagger"
fi


# install lofar
# Note: hack to force use of a specific LAPACK/BLAS
# Note: remove vraiants.fs5 to prevent using this file on the head note
# Note: alter generic GNU file to use the loaded compiler
if ( $INSTALL_LOFAR ); then
echo `date` "Started install-lofar"
mkdir -p ${LOFAR_ROOT_DIR}/build/gnu_opt
cd ${LOFAR_ROOT_DIR}
svn --non-interactive -q --username lofar-guest --password lofar-guest co https://svn.astron.nl/LOFAR/tags/LOFAR-Release-${LOFAR_VERSION} src
rm ${LOFAR_ROOT_DIR}/src/CMake/variants/variants.fs5
sed -i.bak 's+/usr/bin/++g' ${LOFAR_ROOT_DIR}/src/CMake/variants/GNU.cmake
cd ${LOFAR_ROOT_DIR}/build/gnu_opt
cmake -DBUILD_PACKAGES=Offline -DCMAKE_INSTALL_PREFIX=${LOFAR_ROOT_DIR} -DWCSLIB_ROOT_DIR=${WCSLIB_ROOT_DIR} -DCFITSIO_ROOT_DIR=${CFITSIO_ROOT_DIR} -DCASAREST_ROOT_DIR=${CASAREST_ROOT_DIR} -DCASACORE_ROOT_DIR=${CASACORE_ROOT_DIR} -DAOFLAGGER_ROOT_DIR=${AOFLAGGER_ROOT_DIR} -DLOG4CPLUS_ROOT_DIR=${LOG4CPLUS_ROOT_DIR} -DUSE_OPENMP=True -DCMAKE_PREFIX_PATH=${FFTW3_ROOT_DIR} -DLAPACK_lapack_LIBRARY=${LAPACK_ROOT_DIR}/lib64/liblapack.so -DBLAS_blas_LIBRARY=${BLAS_ROOT_DIR}/lib/libblas.so ${LOFAR_ROOT_DIR}/src/
make -j ${J}
make install
echo `date` "Completed install-lofar"
fi


# install wsclean
# Note: install with LOFAR station response correction
# Note: set CPATH as otherwise, if compiled with LOFAR support, in LOFAR header files 
# #include <measures/Measures/MeasFrame.h> from casacore is unknown
if ( $INSTALL_WSCLEAN ); then
echo `date` "Started install-wsclean"
CPATH=${CASACORE_ROOT_DIR}/include/casacore:$CPATH
mkdir -p ${WSCLEAN_ROOT_DIR}/build
cd ${WSCLEAN_ROOT_DIR}
wget http://downloads.sourceforge.net/project/wsclean/wsclean-${WSCLEAN_VERSION}/wsclean-${WSCLEAN_VERSION}.tar.bz2
tar xf wsclean-${WSCLEAN_VERSION}.tar.bz2
cd build
cmake -DCMAKE_INSTALL_PREFIX=${WSCLEAN_ROOT_DIR} -DCMAKE_PREFIX_PATH="${LOFAR_ROOT_DIR};${CASACORE_ROOT_DIR};${CFITSIO_ROOT_DIR};${FFTW3_ROOT_DIR};${GSL_ROOT_DIR}" -DBUILD_SHARED_LIBS=TRUE ../wsclean-${WSCLEAN_VERSION}
make -j ${J}
make install
echo `date` "Completed install-wsclean"
fi
