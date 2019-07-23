#
# Copyright (C) 2019
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

# Write a header
define write-header
	@echo "#"      >> $(2)
	@echo "#" $(1) >> $(2)
	@echo "#"      >> $(2)
endef

# Add number of threads as J flag
define set-build-options
	@$(eval UNAME_S := $(shell uname -s))
	@$(eval J := $(shell \
	if [ $(UNAME_S) == Linux ]; \
	then \
		cat /proc/cpuinfo | grep processor | wc -l; \
	elif [ $(UNAME_S) == Darwin ];  \
	then \
		sysctl -n hw.ncpu; \
	else \
		echo 1; \
	fi))
	@echo "${J}"  >> $(1)
endef

# Make a renamed copy of a file (DOCKERFILE or DEPLOYFILE) in the build directory
define install
	@$(eval NAME := $(shell ${MAKE_DIR}/dirname.sh))
	@mkdir -p ${BUILD_DIR}
	@cp "${PWD}/$(1)" "${BUILD_DIR}/${NAME}-$(1)"
endef
