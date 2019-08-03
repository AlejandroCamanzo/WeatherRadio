#!/bin/bash

# $1 = Satellite Name
# $2 = Frequency
# $3 = FileName base
# $4 = TLE File
# $5 = EPOC start time
# $6 = Time to capture

# 
dir=$(pwd)
#Testing script
touch $dir/testpass
echo a new pass: $1 $2 $3 $4 $5 $6 > $dir/testpass
echo a new pass: $1 $2 $3 $4 $5 $6

# Start GNU Radio script to record
# bla bla bla
