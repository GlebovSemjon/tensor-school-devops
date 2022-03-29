#!/bin/bash
sleep 5s
while [ -f var/out ]
    do
        progress=$( tail -n 1 var/out )
        echo $progress
        sleep 5s
    done
