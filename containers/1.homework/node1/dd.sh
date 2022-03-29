#!/bin/bash
dd if=/dev/urandom of=/file.tmp bs=1024 count=1000000 oflag=direct status='progress' &> /var/out
rm -f /var/out
