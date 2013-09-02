#!/bin/bash
directory="/home/carvac/Photos/2013/07/2013-07-28/pano"
extension=".CR2"
for file in ${directory}/*
do
    echo ${file}
    if [ "${file: -4}" == $extension ]
    then
        echo "converting $item"
        dcraw -W -w -q 3 -4 -H 0 -T $file
    fi
done
