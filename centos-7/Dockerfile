#
# Dockerfiler to build LOFAR software container image
#

# set base image to centos
FROM centos:7

# fix iputils error
RUN yum -y remove iputils

# upgrade packages
RUN yum -y update

#
# setup installation scripts
#
ENV SCRIPTDIR_HOST ./scripts/
ENV SCRIPTDIR /tmp/scripts/
RUN mkdir ${SCRIPTDIR}
COPY ${SCRIPTDIR_HOST}*.sh ${SCRIPTDIR}

#
# install required packages
#
RUN ${SCRIPTDIR}/install-dependencies.sh

#
# create user account
#
ENV USER lofar
RUN ${SCRIPTDIR}/setup-account.sh
USER ${USER}

#
# setup installation directory
#
ENV INSTALLDIR /home/${USER}/opt
RUN mkdir ${INSTALLDIR}

#
# set number of threads for build
#
ENV J 64

#
# install all packages
#
RUN ${SCRIPTDIR}/install-cfitsio.sh
RUN ${SCRIPTDIR}/install-wcslib.sh
RUN ${SCRIPTDIR}/install-casacore.sh
RUN ${SCRIPTDIR}/install-casarest.sh
RUN ${SCRIPTDIR}/install-python-casacore.sh
RUN ${SCRIPTDIR}/install-log4cplus.sh
RUN ${SCRIPTDIR}/install-lofar.sh
#RUN ${SCRIPTDIR}/make_all_tests_work.sh # you don't really need this. This only needs to be done if you want to make sure all tests can in principle succeed.
RUN ${SCRIPTDIR}/execute-tests.sh # If you don't uncomment the previous line, some tests will fail in the lofar tree. 
