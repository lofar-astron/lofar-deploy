#!/bin/bash
patch --follow-symlinks /dev/null /dev/null 2> /dev/null

if [ $? -eq 0 ];
then
echo --follow-symlinks
fi

