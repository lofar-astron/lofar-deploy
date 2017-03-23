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
	@echo "echo \`date\` \"Started $(1)\""   >> ${DEPLOYFILE}
	@${MAKE_DIR}/patch-script.sh $(1) \
	| sed -e '/#/d' -e '/^$$/d'              >> ${DEPLOYFILE}
	@echo "echo \`date\` \"Completed $(1)\"" >> ${DEPLOYFILE}
	@echo ""                                 >> ${DEPLOYFILE}
endef

# Add export, strips comments and empty lines
define script-env
	$(call write-header,$(1),${DEPLOYFILE})
	@${MAKE_DIR}/patch-script.sh $(1) \
	| sed -e '/#/d' -e '/^$$/d' -e 's/ /=/g' -e 's/^/export /' >> ${DEPLOYFILE}
	@echo ""                                                   >> ${DEPLOYFILE}
endef

define script-init
	$(call write-header,$(1),${DEPLOYFILE})
	@echo mkdir -p \$${INSTALLDIR}/bin >> ${DEPLOYFILE}
	@echo 'cat ${COMMON_DIR}/$(1).sh | sed -e "s+\$${INSTALLDIR}+$${INSTALLDIR}+g" > $${INSTALLDIR}/bin/$(1).sh' >> ${DEPLOYFILE}
	@echo 'echo "source $${INSTALLDIR}/bin/$(1).sh" >> $${INSTALLDIR}/init.sh' >> ${DEPLOYFILE}
endef

define script-build-options
        $(call write-header,"build environment", ${DEPLOYFILE})
        @echo -n 'export J='                 >> ${DEPLOYFILE}
        $(call set-build-options,${DEPLOYFILE})
        @echo ""                      >> ${DEPLOYFILE}
endef

# Construct a deploy script
define deploy-file
	@rm -f ${DEPLOYFILE}
	$(call script-env,common-environment)
	$(call script-env,environment)
	$(call script-env,versions)
	$(call script-build-options)
	$(call script-run,base)
	$(call script-run,install-cfitsio)
	$(call script-run,install-wcslib)
	$(call script-run,install-casacore)
	$(call script-run,install-casarest)
	$(call script-run,install-python-casacore)
	$(call script-run,install-pybdsf)
	$(call script-run,install-aoflagger)
	$(call script-run,install-log4cplus)
	$(call script-run,install-lofar)
	$(call script-init,init-lofar)
	$(call install,${DEPLOYFILE})
endef
