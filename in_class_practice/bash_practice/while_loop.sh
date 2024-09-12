#!/bin/bash

while [[ $i -lt 10 ]]; do
	echo $i;
	(( i += 1 ))
done


# use while loop to read files
while read line; do
	echo $line
done < spinup_config.ameriflux_site.MDS.subset.csv 
