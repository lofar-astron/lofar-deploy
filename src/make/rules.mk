#
# Copyright (C) 2015
# This file is part of lofar-profiling.
# 
# lofar-profiling is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# lofar-profiling is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with lofar-profiling.  If not, see <http://www.gnu.org/licenses/>.
#

# Set default shell
SHELL=/bin/bash

default: dockerfile script

# Rule to create a Dockerfile
dockerfile:
	$(call docker-file,${BASE})

# Rule to build a container
build:
	$(call docker-file,${BASE})
	$(call docker-build)

# Rule to create a deploy script
script:
	$(call deploy-file)

# Rule to cleanup Dockerfile and deploy.sh
clean:
	@rm -f ${DOCKERFILE}
	@rm -f ${DEPLOYFILE}
	@rm -f ${BUILD_DIR}/*${DOCKERFILE}
	@rm -f ${BUILD_DIR}/*${DEPLOYFILE}
