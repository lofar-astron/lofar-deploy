DOCKERFILE=Dockerfile
SRC_DIR=src
BUILD_DIR=build
IMAGE_PREFIX=test

define prefix
	@echo "#"      >> ${NAME}/${DOCKERFILE}
	@echo "#" $(1) >> ${NAME}/${DOCKERFILE}
	@echo "#"      >> ${NAME}/${DOCKERFILE}
endef

define docker-run
	$(call prefix,$(1))                                          >> ${NAME}/${DOCKERFILE}
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/RUN /' ${SRC_DIR}/$(1).mk >> ${NAME}/${DOCKERFILE}
	@echo ""                                                     >> ${NAME}/${DOCKERFILE}
endef

define docker-env
	$(call prefix,$(1))
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' < ${SRC_DIR}/$(1).mk >> ${NAME}/${DOCKERFILE}
	@echo ""            >> ${NAME}/${DOCKERFILE}
endef

define docker-from
	@echo "FROM " $(1) >> ${NAME}/${DOCKERFILE}
	@echo ""           >> ${NAME}/${DOCKERFILE}
endef

define docker-user
	@echo "USER $$""{USER}" >> ${NAME}/${DOCKERFILE}
	@echo ""                >> ${NAME}/${DOCKERFILE}
endef

define build
	docker build -t ${IMAGE_PREFIX}-$(1) $(1)
endef

define dockerfile
	mkdir -p ${NAME}
	@rm -f ${NAME}/${DOCKERFILE}
	$(call docker-from,$(1))
	$(call docker-env,common-environment)
	$(call docker-env,${NAME}-environment)
	$(call docker-run,${NAME}-base)
	$(call docker-run,${NAME}-dependencies)
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

dockerfile-centos-7: NAME="centos-7"
dockerfile-centos-7:
	$(call dockerfile,"centos:7")

build-centos-7: NAME="centos-7"
build-centos-7:
	$(call dockerfile,"centos:7")
	$(call build,${NAME})

dockerfile-centos-6: NAME="centos-6"
dockerfile-centos-6:
	$(call dockerfile,"centos:6")

build-centos-6: NAME="centos-6"
build-centos-6:
	$(call dockerfile,"centos:6")
	$(call build,${NAME})

