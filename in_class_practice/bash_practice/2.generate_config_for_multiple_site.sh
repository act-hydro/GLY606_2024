#!/bin/bash

# ======================== #
# Step 1: create a folder to save config files #
# ======================== #

# Define the targeted output folder
odir="./config/"

# check whether the targeted output folder exists
# if this folder does not exist, create it
if [ ! -f ${odir} ]; then
	mkdir ${odir}
fi

# ======================== #
# Step 2: create config files for each site #
# ======================== #

# read the site information 
for line in `cat ./spinup_config.ameriflux_site.MDS.subset.csv`; do
	
	# Split the strings by comma ","
	IFS=",";
	set -- $line
	site_id=$1
	date_ic=$2
	start_date=$3
	run_days=$5
	unset IFS
	
	# print information for each site
	echo "Site ID     :"    $site_id
	echo "IC date     :"    $date_ic
	echo "Start date  :"    $start_date
	echo "# of days   :"    $run_days
	
	# Rule: never overwrite source files or template files!
	# Always make changes to a copy
	temp_file="ufs-land.namelist.template"
	site_file="${odir}ufs-land.namelist.${site_id}"

	# save the changes to a copy of template file
	sed "s#REGION#${site_id}#g" $temp_file > $site_file
	
	# make modification to the targeted file
	sed -i "s#DATE_IC#${date_ic}#g" $site_file
	sed -i "s#START_DATE#${start_date}#g" $site_file
	sed -i "s#RUN_DAYS#${run_days}#g" $site_file

done


