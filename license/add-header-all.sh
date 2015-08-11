#!/bin/bash
for f in `find .. -type f -name "*.sh" -o -name "*.mk" | grep -v "license"`
do
    ./add-header.sh $f > $f-$$
    mv $f-$$ $f
done
