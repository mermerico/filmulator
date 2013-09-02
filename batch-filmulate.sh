#!/bin/bash
directory="."
extension=$1
#The extension must include the '.' and not have any quotes.
count=0
for file in ${directory}/*${extension}
do
    count=$[$count+1]
done
count2=0
for file in ${directory}/*${extension}
do
    count2=$[$count2+1]
    echo "Item $count2 of $count"
    echo "filmulating..."
    filmulator $file
done
