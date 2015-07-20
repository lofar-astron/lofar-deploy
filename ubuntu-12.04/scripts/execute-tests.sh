#!/bin/bash
cd ${INSTALLDIR}/casacore/build &&
make test &&
cd ${INSTALLDIR}/lofar/build/gnu_opt &&
make test
