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
	@$(eval SCRIPT_FILE := $(1).sh)
	@$(eval PATCH_FILE := $(1).patch)
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		patch --follow-symlinks ../common/$(1).sh ${PATCH_FILE} -o - 2> /dev/null; \
	fi \
	| sed -e '/#/d' -e '/^$$/d' -e 's/^/RUN /' >> ${DOCKERFILE}
	@echo "" >> ${DOCKERFILE}
endef

# Add docker ENV command, strips comments and empty lines
define docker-env
	$(call write-header,$(1),${DOCKERFILE})
	@$(eval SCRIPT_FILE := $(1).sh)
	@$(eval PATCH_FILE := $(1).patch)
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		patch --follow-symlinks ../common/$(1).sh ${PATCH_FILE} -o - 2> /dev/null; \
	fi \
	| sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' >> ${DOCKERFILE}
	@echo "" >> ${DOCKERFILE}
endef

# Build docker container
define docker-build
	@$(eval CONTAINER_NAME := ${CONTAINER_PREFIX}-$(shell sed "s/:/-/" <<< ${BASE}))
	@docker build -t ${CONTAINER_NAME} .
endef

# Add user id of the user calling this Makefile
define docker-set-uid
	$(call write-header,set-uid,${DOCKERFILE})
	@$(eval UID = $(shell id -u))
	@echo "ENV UID ${UID}" >> ${DOCKERFILE}
	@echo "" >> ${DOCKERFILE}
endef

# Construct a full Dockerfile
define docker-file
	@rm -f ${DOCKERFILE}
	$(call docker-from,$(1))
	$(call docker-env,common-environment)
	$(call docker-env,environment)
	$(call docker-env,versions)
	$(call docker-set-uid)
	$(call set-build-options,${DOCKERFILE})
	$(call docker-run,base)
	$(call docker-run,setup-account)
	$(call docker-user)
	$(call docker-run,install-cfitsio)
	$(call docker-run,install-wcslib)
	$(call docker-run,install-casacore)
	$(call docker-run,install-casarest)
	$(call docker-run,install-python-casacore)
	$(call docker-run,install-log4cplus)
	$(call docker-run,install-lofar)
endef

define docker-test-file
	$(call docker-file,$(1))
	$(call docker-run,prepare-tests)
	$(call docker-run,tests)
	$(call docker-run,run-tests)
endef 
