# Add command, strips comments and empty lines
define script-run
	$(call write-header,$(1),${DEPLOYFILE})
	@$(eval SCRIPT_FILE := $(1).sh)
	@$(eval PATCH_FILE := $(1).patch)
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		patch --follow-symlinks ../common/$(1).sh ${PATCH_FILE} -o - 2> /dev/null; \
	fi \
	| sed -e '/#/d' -e '/^$$/d' >> ${DEPLOYFILE}
	@echo ""                    >> ${DEPLOYFILE}
endef

# Add export, strips comments and empty lines
define script-env
	$(call write-header,$(1),${DEPLOYFILE})
	@$(eval SCRIPT_FILE := $(1).sh)
	@$(eval PATCH_FILE := $(1).patch)
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		patch --follow-symlinks ../common/$(1).sh ${PATCH_FILE} -o - 2> /dev/null; \
	fi \
	| sed -e '/#/d' -e '/^$$/d' -e 's/ /=/g' -e 's/^/export /' >> ${DEPLOYFILE}
	@echo ""                                                   >> ${DEPLOYFILE}
endef

# Construct a deploy script
define deploy-file
	@rm -f ${DEPLOYFILE}
	$(call script-env,common-environment)
	$(call script-env,environment)
	$(call script-env,versions)
	$(call script-run,base)
	$(call script-run,install-cfitsio)
	$(call script-run,install-wcslib)
	$(call script-run,install-casacore)
	$(call script-run,install-casarest)
	$(call script-run,install-python-casacore)
	$(call script-run,install-log4cplus)
	$(call script-run,install-lofar)
endef
