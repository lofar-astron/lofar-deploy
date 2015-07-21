#
# Dockerfiler to build LOFAR software container image
#

# set base image to centos
FROM ubuntu:14.04

# upgrade packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y

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
RUN ${SCRIPTDIR}/install-lofar.sh
# Running tests moved to integration testing
