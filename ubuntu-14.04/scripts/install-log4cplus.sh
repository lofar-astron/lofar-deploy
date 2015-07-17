#!/bin/bash
mkdir ${INSTALLDIR}/log4cplus
cd ${INSTALLDIR}/log4cplus
wget http://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/1.1.3/log4cplus-1.1.3-rc4.tar.bz2
tar xf log4cplus-1.1.3-rc4.tar.bz2
cd log4cplus-1.1.3-rc4
./configure --prefix=${INSTALLDIR}/log4cplus
make -j ${J}
make install
