#!/bin/bash


grep -Ei $1.*$2 $3 | awk -F' ' '{print $1,$2,$5,$6}'
#This still needs some work. Entering a 1 for the first argument
#results in returns of 01, 10, 11, and 12 for the time. Also, some 
#other numbers entered for the first argument result the second argument
#being ignored, such as 6.  It returns both 6 AM and 6 PM.


##grep  '$1\|$2' $3 | awk -F' ' '{print $1,$2,$5,$6}' 






