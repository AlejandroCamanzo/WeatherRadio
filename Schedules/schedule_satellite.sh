#!/bin/bash

# This script schedules a specific satellite's passes
# ${1} = Satellite name
# ${2} = Satellite transmission frecuency


# Initial prediction
PREDICTION_START=$(predict -t ~/weather.tle -p "${1}" | head -1)
PREDICTION_END=$(predict -t ~/weather.tle -p "${1}" | tail -1)
MAXELEV=$(predict -t ~/weather.tle -p "${1}" | awk -v max=0 '{if($5>max){max=$5}}END{print max}')
ends=$(echo $PREDICTION_END | cut -d " " -f 1)


while [ $(date --date="TZ=\"UTC\" @$ends" +%D) == `date +%D` ]; do

echo ----- new prediction -----
echo start: "$PREDICTION_START"
echo end: "$PREDICTION_END"
echo max elev: "$MAXELEV"

START_TIME=$(echo $PREDICTION_START | cut -d " " -f 3-4)
starts=$(echo $PREDICTION_START | cut -d " " -f 1)
var=$(echo $START_TIME | cut -d " " -f 2 | cut -d ":" -f 3)

TIMER=`expr $ends - $starts + $var`
OUTDATE=`date --date="TZ=\"UTC\" $START_TIME" +%Y%m%d-%H%M%S`

if [ $MAXELEV -gt 19 ]
  then
    echo Satellite pass valid, scheduling recording
    echo ${1//" "}${OUTDATE} $MAXELEV
    echo "$dir/capture_satellite_pass.sh \"${1}\" $2 $dir/../${1//" "}${OUTDATE} ~/weather.tle $starts $TIMER" | at `date --date="TZ=\"UTC\" $START_TIME" +"%H:%M %D"`

fi

# Next prediction
nextpredict=`expr $ends + 60`
PREDICTION_START=`predict -t ~/weather.tle -p "${1}" $nextpredict | head -1`
PREDICTION_END=`predict -t ~/weather.tle -p "${1}"  $nextpredict | tail -1`
MAXELEV=`predict -t ~/weather.tle -p "${1}" $nextpredict | awk -v max=0 '{if($5>max){max=$5}}END{print max}'`
ends=`echo $PREDICTION_END | cut -d " " -f 1`

done
echo finished scheduling