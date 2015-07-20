#!/bin/bash
cd ${INSTALLDIR}/casacore/build &&
make test &&
cd ${INSTALLDIR}/log4cplus/build &&
make test &&
cd ${INSTALLDIR}/lofar/build/gnu_opt &&
make test &&
