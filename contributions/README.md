# Contributions

This directory is meant for contributed install scripts that have been used to successfully install the LOFAR software on your own, external system. Please add any install scripts using a pull request.

Note that those scripts have been proven to work in a specific environment. Don't expect them to work out of the box without any changes.

List of scripts:  
deploy-das5.sh - Used to deploy the software on the ASTRON cluster of DAS5 to be used on the whole cluster.  (by Matthias Petschow)
deploy-2.21-das5.sh - Used to deploy 2.21 on ASTRON cluster of DAS5 using modules of previously built packages. (by Yan Grange)
flits - Contains deploy-flits.sh which is used to deploy the software in a virtualenv on a flits node. The two other files are patches to extend the virtualenv funtionality to our needs. (by Yan Grange and Aleksandar Shulevski)
LOFAR2.21.4-centos-7-Dockerfile - Dockerfile to build LOFAR 2.21.4 on a CENTOS 7 container. The Dockerfile builds the part of the Offline software stack that does not depend on casarest. Most importantly, this means that AWImager and older parts of BBS are not installed. The install is built so that it can run prefactor. (by Yan Grange)
