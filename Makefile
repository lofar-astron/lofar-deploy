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

define build
    @cd $(1) && make
endef

define clean
	@cd $(1) && make clean
endef

default:
	$(call build,src/deb/ubuntu/14.04)
	$(call build,src/deb/ubuntu/12.04)
	$(call build,src/deb/debian/7)
	$(call build,src/deb/debian/8)
	$(call build,src/rpm/centos/6)
	$(call build,src/rpm/centos/6.4)
	$(call build,src/rpm/centos/7)
	$(call build,src/rpm/fedora/21)
	$(call build,src/rpm/fedora/23)
	$(call build,src/rpm/suse/42.1)

clean:
	$(call clean,src/deb/ubuntu/14.04)
	$(call clean,src/deb/ubuntu/12.04)
	$(call clean,src/deb/debian/7)
	$(call clean,src/deb/debian/8)
	$(call clean,src/rpm/centos/6)
	$(call clean,src/rpm/centos/6.4)
	$(call clean,src/rpm/centos/7)
	$(call clean,src/rpm/fedora/21)
	$(call clean,src/rpm/fedora/23)
	$(call build,src/rpm/suse/42.1)
