#!/bin/bash
FILE=$1

# Count number of lines in license file
LINES=$(eval ./print-header.sh | wc -l)

# Add padding lines
LINES=$(expr ${LINES} + 1)
tail ${FILE} --lines=+${LINES}
