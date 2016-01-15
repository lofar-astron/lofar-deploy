#!/bin/bash
HEADER_FILE=header.txt
export YEAR=$(eval date +"%Y")
export PROGRAM=lofar-profiling
echo "#"
envsubst < header.txt | sed -e 's/^/# /'
echo -e "#\n"
