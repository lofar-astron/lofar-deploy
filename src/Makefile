FILE_PREFIX=Dockerfile

define prefix
	@echo "#"      >> ${FILE}
	@echo "#" $(1) >> ${FILE}
	@echo "#"      >> ${FILE}
endef

define run
	$(call prefix,$(1)) >> ${FILE}
	@echo "RUN \\"      >> ${FILE}
	@cat $(1).mk        >> ${FILE}
	@echo ""            >> ${FILE}
endef

define env
	$(call prefix,$(1))
	@sed -e '/#/d' -e '/^$$/d' -e 's/^/ENV /' < $(1).mk >> ${FILE}
	@echo ""            >> ${FILE}
endef

define from
	@echo "FROM " $(1) >> ${FILE}
	@echo ""           >> ${FILE}
endef

define user
	@echo "USER lofar" >> ${FILE} #fixme: read lofar from env
	@echo ""
endef

define build
	@mkdir -p build-$(1)
	@cp ${FILE} build-$(1)/${FILE_PREFIX}
	docker build -t test-$(1) build-$(1)
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
