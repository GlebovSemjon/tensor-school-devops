#!/bin/bash
TS=$(date +%s%N)
LA=$(cat /proc/loadavg)
echo loadavg,task=4 LA1=${LA:0:4},LA5=${LA:5:4},LA15=${LA:10:4} $TS
