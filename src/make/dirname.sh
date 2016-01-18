#!/bin/bash

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
# This script returns the (patched) shell script that is passed as input
# It will start looking in the current directory, and will go the  parent
# directory when the file is not found. When a patch file is found instead,
# it will continue looking for the corresponding script and patch it.
# Note that the first occurrence of a file is taken into account. This allows
# for overriding top-level scripts or patches for specific distributions.
#
NAME=$(eval pwd | awk -F/ '{print $(NF-1)"-"$NF}')
echo ${NAME}
