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
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/RUN /' $(2)/$(1).sh >> ${DOCKERFILE}
	@echo ""                                               >> ${DOCKERFILE}
endef

# Add docker ENV command, strips comments and empty lines
define docker-env
	$(call write-header,$(1),${DOCKERFILE})
	@$(eval SCRIPT_FILE :=$(2)/$(1).sh)
	@$(eval PATCH_FILE :=$(2)/$(1).patch)
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		patch $(2)/../common/$(1).sh ${PATCH_FILE} -o - 2> /dev/null; \
	fi \
	| sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' >> ${DOCKERFILE}
	@echo "" >> ${DOCKERFILE}
endef

# Build docker container
define docker-build
	@$(eval CONTAINER_NAME := ${CONTAINER_PREFIX}-$(shell sed "s/:/-/" <<< ${BASE}))
	@docker build -t ${CONTAINER_NAME} .
endef

# Construct a full Dockerfile
define docker-file
	@rm -f ${DOCKERFILE}
	$(call docker-from,$(1))
	$(call docker-env,common-environment,${SRC_DIR})
	$(call docker-env,environment,.)
	$(call docker-run,base,.)
	$(call docker-run,setup-account,${SRC_DIR})
	$(call docker-user)
	$(call docker-run,install-cfitsio,${SRC_DIR})
	$(call docker-run,install-wcslib,${SRC_DIR})
	$(call docker-run,install-casacore,${SRC_DIR})
	$(call docker-run,install-casarest,${SRC_DIR})
	$(call docker-run,install-python-casacore,${SRC_DIR})
	$(call docker-run,install-log4cplus,${SRC_DIR})
	$(call docker-run,install-lofar,${SRC_DIR})
endef

define docker-test-file
	$(call docker-file,$(1))
	$(call docker-run,testprep,.)
	$(call docker-run,prepare-tests,${SRC_DIR})
    $(call docker-run,ests,.)
	$(call docker-run,run-tests,${SRC_DIR})
endef 
