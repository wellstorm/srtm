#!/bin/bash
#38..49
for lat in {25..98}
do
    for lon in {84..100}
    do
        url=`printf "http://dds.cr.usgs.gov/srtm/version2_1/SRTM1/Region_05/N%02dW%03d.hgt.zip" $lat $lon`
        echo $url
        wget -r $url
    done
done

    