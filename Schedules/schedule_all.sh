#!/bin/bash

#Get folder info
dir=$(pwd)

# Update Satellite Information
wget -qr http://www.celestrak.com/NORAD/elements/weather.txt -O $dir/weather.txt
# TLE file is stored in the home directory, as adresses too long cause issues in predict
grep "NOAA 15" $dir/weather.txt -A 2 > ~/weather.tle
grep "NOAA 18" $dir/weather.txt -A 2 >> ~/weather.tle
grep "NOAA 19" $dir/weather.txt -A 2 >> ~/weather.tle
grep "METEOR-M 2" $dir/weather.txt -A 2 >> ~/weather.tle

#Remove all AT jobs
for i in `atq | awk '{print $1}'`;do atrm $i;done

#Schedule Satellite Passes:
$dir/schedule_satellite.sh "NOAA 19" 137.1000
$dir/schedule_satellite.sh "NOAA 18" 137.9125
$dir/schedule_satellite.sh "NOAA 15" 137.6200