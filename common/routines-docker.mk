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

# add -u $(id -u) as a variable t the docker build script
define docker-uid
	$(call write-header, host-userid-flag, ${DOCKERFILE})
	@$(eval UID = $(shell id -u))
	@echo "ENV ADDUSER_FLAGS \"-u ${UID}\"" >> ${DOCKERFILE}
endef

# Construct a full Dockerfile
define docker-file
	@rm -f ${DOCKERFILE}
	$(call docker-from,$(1))
	$(call docker-env,common-environment)
	$(call docker-uid)
	$(call docker-env,environment)
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
	$(call docker-run,testprep)
	$(call docker-run,prepare-tests)
	$(call docker-run,tests)
	$(call docker-run,run-tests)
endef 
