#!/bin/bash


# Update Satellite Information7
wget -qr http://www.celestrak.com/NORAD/elements/weather.txt -O /tmp/weather.txt
# TLE file is stored in the home directory, as adresses too long cause issues in predict
grep "NOAA 15" /tmp/weather.txt -A 2 > /tmp/weather.tle
grep "NOAA 18" /tmp/weather.txt -A 2 >> /tmp/weather.tle
grep "NOAA 19" /tmp/weather.txt -A 2 >> /tmp/weather.tle
grep "METEOR-M 2" /tmp/weather.txt -A 2 >> /tmp/weather.tle

#Remove all AT jobs
for i in `atq | awk '{print $1}'`;do atrm $i;done

#Schedule Satellite Passes:
/home/pi/Repositories/WeatherRadio/Schedules/schedule_satellite.sh "NOAA 19" 137.1000
/home/pi/Repositories/WeatherRadio/Schedules/schedule_satellite.sh "NOAA 18" 137.9125
/home/pi/Repositories/WeatherRadio/Schedules/schedule_satellite.sh "NOAA 15" 137.6200
