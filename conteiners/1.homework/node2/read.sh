#!/bin/bash
sleep 5s
while [ -f var/out ]
    do
        tail -n 1 var/out
        sleep 5s
    done
