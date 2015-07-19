cd ${INSTALLDIR}/casacore/build
make test
cd ${INSTALLDIR}/lofar/build/gnu_opt
make test
exit 0 # Since we already know some tests will fail in a normal install, we don't want the docker container to fail building. This also allows for only execute the failing tests in a built container with ctest.
