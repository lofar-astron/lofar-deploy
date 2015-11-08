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

# Add command, strips comments and empty lines
define script-run
	$(call write-header,$(1),${DEPLOYFILE})
	@$(eval SCRIPT_FILE := $(1).sh)
	@$(eval PATCH_FILE := $(1).patch)
	@$(eval PATCH_FLAG := $(shell ../../../common/scripts/test-patch.sh))
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		ln -s ../common/$(1).sh to_patch && \
		patch ${PATCH_FLAG} to_patch ${PATCH_FILE} -o - 2>> ./patch_log  && \
		rm -f to_patch; \
	fi \
	| sed -e '/#/d' -e '/^$$/d' >> ${DEPLOYFILE}
	@echo ""                    >> ${DEPLOYFILE}
endef

# Add export, strips comments and empty lines
define script-env
	$(call write-header,$(1),${DEPLOYFILE})
	@$(eval SCRIPT_FILE := $(1).sh)
	@$(eval PATCH_FILE := $(1).patch)
	@$(eval PATCH_FLAG := $(shell ../../../common/scripts/test-patch.sh))
	@if [ -a ${SCRIPT_FILE} ]; \
	then \
		cat ${SCRIPT_FILE}; \
	else \
		ln -s ../common/$(1).sh to_patch && \
		patch ${PATCH_FLAG} to_patch ${PATCH_FILE} -o - 2> ./dev/null && \
		rm -f to_patch; \
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
