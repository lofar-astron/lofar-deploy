#!/bin/bash
FILE=$1
#HEADER=$(eval grep '^[#]' ${FILE})
LINES=$(eval grep '^[#]' ${FILE} | wc -l)
if [ $LINES -ge 1 ]
then
    LINES=$(expr ${LINES} + 2)
    tail ${FILE} --lines=+${LINES}
else
    cat ${FILE}
fi
