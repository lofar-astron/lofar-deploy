#
# base
#
FROM  ubuntu:12.04

#
# common-environment
#
ENV USER lofar
ENV INSTALLDIR /home/${USER}/opt
ENV J 48
ENV CFITSIO_VERSION 3370
ENV WCSLIB_VERSION 5.9
ENV LOG4CPLUS_VERSION 1.1.x

#
# environment
#
ENV DEBIAN_FRONTEND noninteractive
ENV COMMAND_ADD_USER useradd
ENV PYTHON_VERSION 2.7

#
# base
#
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install sudo
RUN apt-get -y install git subversion wget
RUN apt-get -y install automake autotools-dev cmake make python-setuptools
RUN apt-get -y install  g++ gcc gfortran
RUN apt-get -y install libblas-dev libfftw3-dev python-dev liblapack-dev libpng-dev libxml2-dev python-numpy libreadline-dev libncurses-dev python-scipy liblog4cplus-dev
RUN apt-get -y install libboost-dev libboost-python-dev libboost-thread-dev libboost-system-dev libboost-filesystem-dev libboost-iostreams-dev
RUN apt-get -y install bison bzip2 flex csh python-xmlrunner python-pip
RUN pip install pyfits pywcs python-monetdb

#
# setup-account
#
RUN getent group sudo &>/dev/null || groupadd sudo
RUN ${COMMAND_ADD_USER} -m ${USER}
RUN usermod -a -G sudo ${USER}
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sed -i 's/requiretty/!requiretty/g' /etc/sudoers

USER ${USER}

#
# install-cfitsio
#
RUN mkdir -p ${INSTALLDIR}/cfitsio/build
RUN cd ${INSTALLDIR}/cfitsio && wget --retry-connrefused ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio${CFITSIO_VERSION}.tar.gz
RUN cd ${INSTALLDIR}/cfitsio && tar xf cfitsio${CFITSIO_VERSION}.tar.gz
RUN cd ${INSTALLDIR}/cfitsio/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/cfitsio/ ../cfitsio
RUN cd ${INSTALLDIR}/cfitsio/build && make -j ${J}
RUN cd ${INSTALLDIR}/cfitsio/build && make install

#
# install-wcslib
#
RUN mkdir ${INSTALLDIR}/wcslib
RUN cd ${INSTALLDIR}/wcslib && wget --retry-connrefused ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib-${WCSLIB_VERSION}.tar.bz2
RUN cd ${INSTALLDIR}/wcslib && tar xf wcslib-*.tar.bz2
RUN cd ${INSTALLDIR}/wcslib/wcslib* && ./configure --prefix=${INSTALLDIR}/wcslib --with-cfitsiolib=${INSTALLDIR}/cfitsio/lib/ --with-cfitsioinc=${INSTALLDIR}/cfitsio/include/ --without-pgplot
RUN cd ${INSTALLDIR}/wcslib/wcslib* && make
RUN cd ${INSTALLDIR}/wcslib/wcslib* && make install

#
# install-casacore
#
RUN mkdir -p ${INSTALLDIR}/casacore/build
RUN mkdir -p ${INSTALLDIR}/casacore/data
RUN cd ${INSTALLDIR}/casacore && git clone https://github.com/casacore/casacore.git src
RUN cd ${INSTALLDIR}/casacore/data && wget --retry-connrefused ftp://ftp.astron.nl/outgoing/Measures/WSRT_Measures.ztar
RUN cd ${INSTALLDIR}/casacore/data && tar xf WSRT_Measures.ztar
RUN cd ${INSTALLDIR}/casacore/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casacore/ -DDATA_DIR=${INSTALLDIR}/casacore/data -DWCSLIB_ROOT_DIR=/${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DBUILD_PYTHON=True -DUSE_OPENMP=True -DUSE_FFTW3=TRUE ../src/
RUN cd ${INSTALLDIR}/casacore/build && make -j ${J}
RUN cd ${INSTALLDIR}/casacore/build && make install

#
# install-casarest
#
RUN mkdir -p ${INSTALLDIR}/casarest/build
RUN cd ${INSTALLDIR}/casarest && svn co --quiet https://svn.astron.nl/casarest/trunk/casarest/ src
RUN cd ${INSTALLDIR}/casarest/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/casarest -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio ../src/
RUN cd ${INSTALLDIR}/casarest/build && make -j ${J}
RUN cd ${INSTALLDIR}/casarest/build && make install

#
# install-python-casacore
#
RUN mkdir ${INSTALLDIR}/python-casacore
RUN cd ${INSTALLDIR}/python-casacore && git clone https://github.com/casacore/python-casacore
RUN cd ${INSTALLDIR}/python-casacore/python-casacore ./setup.py build_ext -I${INSTALLDIR}/wcslib/include:${INSTALLDIR}/casacore/include/:${INSTALLDIR}/cfitsio/include -L${INSTALLDIR}/wcslib/lib:${INSTALLDIR}/casacore/lib/:${INSTALLDIR}/cfitsio/lib/
RUN mkdir -p ${INSTALLDIR}/python-casacore/lib/python${PYTHON_VERSION}/site-packages/
RUN mkdir -p ${INSTALLDIR}/python-casacore/lib64/python${PYTHON_VERSION}/site-packages/
RUN cd ${INSTALLDIR}/python-casacore/python-casacore ./setup.py install --prefix=${INSTALLDIR}/python-casacore/

#
# install-log4cplus
#
RUN mkdir -p ${INSTALLDIR}/log4cplus/build
RUN cd ${INSTALLDIR}/log4cplus && git clone https://github.com/log4cplus/log4cplus.git -b ${LOG4CPLUS_VERSION} src
RUN cd ${INSTALLDIR}/log4cplus/build && cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/log4cplus ../src/
RUN cd ${INSTALLDIR}/log4cplus/build && make -j ${J}
RUN cd ${INSTALLDIR}/log4cplus/build && make install

#
# install-lofar
#
RUN mkdir -p ${INSTALLDIR}/lofar/build/gnu_opt
RUN cd ${INSTALLDIR}/lofar && svn --non-interactive -q --username lofar-guest --password lofar-guest co https://svn.astron.nl/LOFAR/trunk src
RUN cd ${INSTALLDIR}/lofar/build/gnu_opt && cmake -DBUILD_PACKAGES=Offline -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/lofar/ -DWCSLIB_ROOT_DIR=${INSTALLDIR}/wcslib/ -DCFITSIO_ROOT_DIR=${INSTALLDIR}/cfitsio/ -DCASAREST_ROOT_DIR=${INSTALLDIR}/casarest/ -DCASACORE_ROOT_DIR=${INSTALLDIR}/casacore/ -DLOG4CPLUS_ROOT_DIR=${INSTALLDIR}/log4cplus/ -DUSE_OPENMP=True ${INSTALLDIR}/lofar/src/
RUN cd ${INSTALLDIR}/lofar/build/gnu_opt && sed -i '29,31d' include/ApplCommon/PosixTime.h
RUN cd ${INSTALLDIR}/lofar/build/gnu_opt && make -j ${J}
RUN cd ${INSTALLDIR}/lofar/build/gnu_opt && make install

