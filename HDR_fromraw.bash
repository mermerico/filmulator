#!/bin/bash
directory=$HOME"/Photos/hdr/"
#This should point at the directory with no raw files other than those
# you want to process for this HDR.
# The files should be orderered in 0 + - ++ -- order.
# The directory name should end in a slash.
extension=".CR2"
#The extension is whatever the extension of your raw file is.
count=0
#The count must start at zero; this is just an initialization.
initialexpcomp=3
#This must be an integer.
bracketstep=3
#As must this. It doesn't matter exactly the values, as long as the most negative value is close to what it was when you took the photo. As a guideline.
positive=1
#positive must start at 1; this is just an initialization.
bracketcount=0
#bracketcount must start an 0; this is just an initialization.
for file in ${directory}/*
do
    echo ${file}
    if [ "${file: -4}" == $extension ]
    then
        echo "found $item"
        if [ $positive -eq 0 ]
        then
            bracketcount=$[-$bracketcount-1];
        else
            bracketcount=$[-$bracketcount];
        fi
        echo "count = $count"
        echo "bracketcount = $bracketcount"
        if [ $positive -eq 1 ]
        then
            filenames=(${filenames[@]} ${file} $[$initialexpcomp+$bracketcount*$bracketstep]);
            positive=0;
        else
            filenames=(${file} $[$initialexpcomp+$bracketcount*$bracketstep] ${filenames[@]});
            positive=1;
        fi
        count=$[$count+1]
    else
        echo "not a $extension"
    fi
done
echo "./filmulator -c configuration.txt -h $count ${filenames[@]}"
./filmulator -c HDRconfiguration.txt -h $count ${filenames[@]}
