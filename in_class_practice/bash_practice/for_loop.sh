#!/bin/bash

for i in {1..5}; do
	echo $i; 
done


for line in `cat spinup_config.ameriflux_site.MDS.subset.csv`; do
	echo $line
	echo  
        IFS=","
	set -- $line
	site_id=$1
	init_date=$2
	start_date=$3
	num_run_days=$5
	unset IFS
	echo "site name is:" $site_id
	echo "start date is:" $start_date	
done
