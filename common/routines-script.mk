# Add command, strips comments and empty lines
define script-run
	$(call write-header,$(1),${DEPLOYFILE})
	@sed -e '/#/d' -e '/^$$/d' $(2)/$(1).sh >> ${DEPLOYFILE}
	@echo ""                                >> ${DEPLOYFILE}
endef

# Add export, strips comments and empty lines
define script-env
	$(call write-header,$(1),${DEPLOYFILE})
	@sed -e '/#/d' -e '/^$$/d' -e 's/ /=/g' -e 's/^/export /' < $(2)/$(1).sh >> ${DEPLOYFILE}
	@echo ""                                                                 >> ${DEPLOYFILE}
endef

# Construct a deploy script
define deploy-file
	@rm -f ${DEPLOYFILE}
	$(call script-env,common-environment,${SRC_DIR})
	$(call script-env,${OS}-environment,.)
	$(call script-run,${OS}-base,.)
	$(call script-run,install-cfitsio,${SRC_DIR})
	$(call script-run,install-wcslib,${SRC_DIR})
	$(call script-run,install-casacore,${SRC_DIR})
	$(call script-run,install-casarest,${SRC_DIR})
	$(call script-run,install-python-casacore,${SRC_DIR})
	$(call script-run,install-log4cplus,${SRC_DIR})
	$(call script-run,install-lofar,${SRC_DIR})
endef
