#!/bin/bash

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
# This script returns the (patched) shell script that is passed as input
# It will start looking in the current directory, and will go the  parent
# directory when the file is not found. When a patch file is found instead,
# it will continue looking for the corresponding script and patch it.
# Note that the first occurrence of a file is taken into account. This allows
# for overriding top-level scripts or patches for specific distributions.
#

# File to search for
FILE_NAME=$1

# Start looking in current directory
PATH_CURRENT=.

# Construct initial file path
PATH_FILE=$PATH_CURRENT/$FILE_NAME

# Variables for the resolved paths
PATH_SHELL=
PATH_PATCH=

# Check paths until top-level common
for i in {1..4}
do
    # Check whether .sh file is found
    if [ -z "${PATH_SHELL}" ] && [ -a "${PATH_FILE}.sh" ]
    then
        PATH_SHELL=${PATH_FILE}.sh
    fi

    # Check whether .patch file is found
    if [ -z "${PATH_PATCH}" ] && [ -a "${PATH_FILE}.patch" ]
    then
        PATH_PATCH=${PATH_FILE}.patch
    fi

    # Break whether both files are found
    if [ -n "${PATH_SHELL}" ] && [ -n "${PATH_PATCH}" ]
    then
        break
    fi

    # Update path, look into parent directory
    PATH_CURRENT=${PATH_CURRENT}/..
    PATH_FILE=$PATH_CURRENT/common/$FILE_NAME
    
    # Debug
    #echo "PATH: " $PATH_FILE
done

# Debug
#echo "SCRIPT: " ${PATH_SHELL}
#echo "PATCH:  " ${PATH_PATCH}

# Output the (patched) script
if [ -n "${PATH_PATCH}" ]
then
    # Patch the script
    TMP_SHELL=SCRIPT_$$
    TMP_PATCH=PATCH_$$
    cp ${PATH_SHELL} ${TMP_SHELL}
    cp ${PATH_PATCH} ${TMP_PATCH}
    TMP_OUT=OUT_$$
    patch ${TMP_SHELL} ${TMP_PATCH} -o ${TMP_OUT} &> /dev/null
    cat ${TMP_OUT}
    rm ${TMP_SHELL} ${TMP_PATCH} ${TMP_OUT}
else
    # Output the script
    cat ${PATH_SHELL}
fi
