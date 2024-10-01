#!/bin/sh

for f in `ls performance_pdis*`; do  
    num=`echo ${f} | sed 's/performance_pdis/pdis/g'`
    awk 'NF==2{print $1, 1000/$2}NF==3{print "mcpu day/1micros "$3}' ${f} \
	> cpu_vs_days_of_1micros_${num}
done
