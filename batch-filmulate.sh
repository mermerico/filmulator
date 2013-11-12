#!/bin/bash

usage() { echo "Usage: $0 [-e <string>] [-r] [-o] \n-e: The extension must include the .\n-r: Recursively runs on subdirectories but not this directory.\n-o: Doesn't re-process anything with a tiff already."; exit 1; }
extension=" "
while getopts ":e:ro" opt; do
    case "$opt" in
        e)  
            eflag=1
            eopt=" -e "
            extension=${OPTARG}
            echo "Extension: "$extension
            ;;
        r)  
            rflag=1
            ropt=" -r"
            echo "Recursive"
            ;;
        o)  
            oflag=1
            oopt=" -o"
            echo "Not processing photos with existing *-output.tif's"
            ;;
        *)  
            usage
            ;;
    esac
done

#Here we make sure that there's an extension specified.
if [ -z "${eflag}" ] || [ " " == "${extension}" ]; then
    usage
fi

directory="."
count=0
for file in ${directory}/*${extension}
do
    if [[ $oflag -eq 1 ]]
    then
        #echo ${file}
        #echo ${file:0:$[${#file}-${#extension}]}"-output.tif"
        if [ -e ${file:0:$[${#file}-${#extension}]}"-output.tif" ]
        then
            count=$count
            #echo "Output already exists."
        else
            count=$[$count+1]
        fi
    else
        count=$[$count+1]
    fi
done
if [[ $count -ne 0 ]]
then
    count2=0
    for file in ${directory}/*${extension}
    do
        if [[ $oflag -eq 1 ]]
        then
            if [ -e ${file:0:$[${#file}-${#extension}]}"-output-tif" ]
            then
                count2=$count2
            else
                count2=$[$count2+1]
                echo "Item $count2 of $count"
                echo "filmulating..."
                filmulator $file
            fi
        else
            count2=$[$count2+1]
            echo "Item $count2 of $count"
            echo "filmulating..."
            filmulator $file
        fi
    done
fi

#This recursively runs itself in inner directories.
if [[ $rflag -eq 1 ]]
then
    for dir in ${directory}/*
    do
        if [ -d "${dir}" ]; then
            cd "${dir}"
            echo "Switching directories..."
            echo " "
            echo ${dir}
            echo "batch-filmulate "$eopt$extension$ropt$oopt
            batch-filmulate $eopt$extension$ropt$oopt
            cd ..
        fi
    done
fi


