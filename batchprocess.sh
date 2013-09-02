#!/bin/bash
directory=$HOME"/Photos/temp"
extension=".CR2"
for file in ${directory}/*${extension}
do
    echo $file
    ./filmulator -c configuration.txt $file
done
