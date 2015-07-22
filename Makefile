FILE_PREFIX=Dockerfile
SRC_DIR=src
BUILD_DIR=build

define prefix
	@echo "#"      >> ${BUILD_DIR}/${FILE}
	@echo "#" $(1) >> ${BUILD_DIR}/${FILE}
	@echo "#"      >> ${BUILD_DIR}/${FILE}
endef

define run
	$(call prefix,$(1))   >>   ${BUILD_DIR}/${FILE}
	@echo "RUN \\"        >>   ${BUILD_DIR}/${FILE}
	@cat ${SRC_DIR}/$(1).mk >> ${BUILD_DIR}/${FILE}
	@echo ""              >>   ${BUILD_DIR}/${FILE}
endef

define env
	$(call prefix,$(1))
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' < ${SRC_DIR}/$(1).mk >> ${BUILD_DIR}/${FILE}
	@echo ""            >> ${BUILD_DIR}/${FILE}
endef

define from
	@echo "FROM " $(1) >> ${BUILD_DIR}/${FILE}
	@echo ""           >> ${BUILD_DIR}/${FILE}
endef

define user
	@echo "USER lofar" >> ${BUILD_DIR}/${FILE} #fixme: read lofar from env
	@echo ""
endef

define build
	@mkdir -p ${BUILD_DIR}/$(1)
	@cp ${BUILD_DIR}/${FILE} ${BUILD_DIR}/$(1)/${FILE_PREFIX}
	docker build -t test-$(1) ${BUILD_DIR}/$(1)
endef

centos-7: FILE=${FILE_PREFIX}-$@
centos-7:
	@rm -f ${FILE}
	$(call from,"centos:7")
	$(call env,common-environment)
	$(call env,$@-environment)
	$(call run,$@-base)
	$(call run,$@-dependencies)
	$(call run,setup-account)
	$(call user)
	$(call run,install-cfitsio)
	$(call run,install-wcslib)
	$(call run,install-casacore)
	$(call run,install-casarest)
	$(call run,install-python-casacore)
	$(call run,install-log4cplus)
	$(call run,install-lofar)
	$(call build,$@)

centos-6: FILE=${FILE_PREFIX}-$@
centos-6:
	@rm -f ${FILE}
	$(call from,"centos:6")
	$(call env,common-environment)
	$(call env,$@-environment)
	$(call run,$@-base)
	$(call run,$@-dependencies)
	$(call run,setup-account)
	$(call user)
	$(call run,install-cfitsio)
	$(call run,install-wcslib)
	$(call run,install-casacore)
	$(call run,install-casarest)
	$(call run,install-python-casacore)
	$(call run,install-log4cplus)
	$(call run,install-lofar)
	$(call build,$@)
