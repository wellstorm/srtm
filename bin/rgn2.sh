#!/bin/bash
#38..49
for lat in {38..49}
do
    for lon in {98..111}
    do
        url=`printf "http://dds.cr.usgs.gov/srtm/version2_1/SRTM1/Region_02/N%02dW%03d.hgt.zip" $lat $lon`
        echo $url
        wget -r $url
    done
done

    