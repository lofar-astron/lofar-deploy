# Add docker FROM command
define docker-from
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
	$(call write-header,$(1))
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/RUN /' $(2)/$(1).sh >> ${DOCKERFILE}
	@echo ""                                               >> ${DOCKERFILE}
endef

# Add docker ENV command, strips comments and empty lines
define docker-env
	$(call write-header,$(1))
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' < $(2)/$(1).sh >> ${DOCKERFILE}
	@echo ""                                                 >> ${DOCKERFILE}
endef

# Build docker container
define docker-build
	docker build -t ${IMAGE_PREFIX}-${OS} .
endef

# Construct a full Dockerfile
define docker-file
	@rm -f ${DOCKERFILE}
	$(call docker-from,$(1))
	$(call docker-env,common-environment,${SRC_DIR})
	$(call docker-env,${OS}-environment,.)
	$(call docker-run,${OS}-base,.)
	$(call docker-run,${OS}-dependencies,.)
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
