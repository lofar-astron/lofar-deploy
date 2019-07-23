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

# Add docker FROM command
define docker-from
	$(call write-header,"base",${DOCKERFILE})
	@echo "FROM " $(1) >> ${DOCKERFILE}
	@echo ""           >> ${DOCKERFILE}
endef

# Add docker USER command
define docker-user
	@echo "USER $$""{USER}" >> ${DOCKERFILE}
	@echo ""                >> ${DOCKERFILE}
endef

# Add docker RUN command, strips comments and empty lines
define docker-run
	$(call write-header,$(1),${DOCKERFILE})
	@${MAKE_DIR}/patch-script.sh $(1) \
	| sed -E 's/export ([A-Z0-9_]*_VERSION)=(.+)/ENV \1 \2/' \
   	| sed -e '/#/d' \
	| sed -e '/^$$/d' \
	| sed -e '/^ENV/! s/^/RUN /g' >> ${DOCKERFILE}
	@echo ""				      >> ${DOCKERFILE}
endef

# Add docker ENV command, strips comments and empty lines
define docker-env
	$(call write-header,$(1),${DOCKERFILE})
	@${MAKE_DIR}/patch-script.sh $(1) \
	| sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' >> ${DOCKERFILE}
	@echo ""                                   >> ${DOCKERFILE}
endef

define docker-init
	$(call write-header,$(1),${DOCKERFILE})
	@cat ${COMMON_DIR}/$(1).sh | sed -e '/#/d' -e '/^$$/d' -e "s/^\(.*\)/RUN sudo sh -c 'echo \1 >> \/usr\/bin\/$(1).sh'/g" -e 's~\$$~\\$$~g' >> ${DOCKERFILE}
	@echo 'RUN sudo sh -c "echo source /usr/bin/$(1).sh >> /usr/bin/init.sh"' >> ${DOCKERFILE}
	@echo ""                                                                  >> ${DOCKERFILE}
endef

# Build docker container
define docker-build
	@$(eval CONTAINER_NAME := ${CONTAINER_PREFIX}-$(shell sed "s/:/-/" <<< ${BASE}))
	@docker build -t ${CONTAINER_NAME}
endef

# Add user id of the user calling this Makefile
define docker-set-uid
	$(call write-header,set-uid,${DOCKERFILE})
	@$(eval UID = $(shell id -u))
	@echo "ENV UID ${UID}" >> ${DOCKERFILE}
	@echo "" >> ${DOCKERFILE}
endef

define docker-entrypoint
endef

define docker-build-options
        $(call write-header,"build environment", ${DOCKERFILE})
	@echo -n 'ENV J '                 >> ${DOCKERFILE}
	$(call set-build-options,${DOCKERFILE})
	@echo ""                      >> ${DOCKERFILE}
endef

# Construct a full Dockerfile
define docker-file
	@rm -f ${DOCKERFILE}
	$(call docker-from,$(1))
	$(call docker-env,common-environment)
	$(call docker-env,environment)
	$(call docker-set-uid)
	$(call docker-build-options)
	$(call docker-run,base)
	$(call docker-run,setup-account)
	$(call docker-user)
	$(call docker-run,install-cmake)
	$(call docker-run,install-boost)
	$(call docker-run,install-cfitsio)
	$(call docker-run,install-wcslib)
	$(call docker-run,install-casacore)
	$(call docker-run,install-hdf5)
	$(call docker-run,install-python-casacore)
	$(call docker-run,install-aoflagger)
	$(call docker-run,install-idg)
	$(call docker-run,install-lofarbeam)
	$(call docker-run,install-wsclean)
	$(call docker-run,install-dysco)
	$(call docker-run,install-dp3)
	$(call install,${DOCKERFILE})
endef
