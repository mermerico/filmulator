#!/bin/bash
directory=$HOME"/Photos/temp/testing"
extension=".tiff"
for file in ${directory}/*${extension}
do
    ./filmulator -w 1 -t -c configuration.txt $file -0
done
