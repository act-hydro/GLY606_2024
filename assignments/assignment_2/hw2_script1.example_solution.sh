#!/bin/bash

for line in `cat gly606_hw2/site_list.txt`; do
	# Step 1: extract site_id and model run year
	#         from "gly606_hw2/site_list.txt" file
	# Example script: https://github.com/act-hydro/GLY606_2024/blob/main/in_class_practice/bash_practice/for_loop.sh

	IFS=","
	set -- $line
	site=$1
	start_year=$2
	unset IFS
	echo "site_id is " $site
	echo "year is "   $start_year

	# Step 2: make directory (mkdir) for each site

	mkdir model_run/$site
	
	# Step 3: within each site directory, make sub-directory
	#         to store initial condition, forcing, and static file

	for subdir in init forcing static; do
		mkdir model_run/$site/$subdir
	done
	
	# Step 4: copy files (cp) from "gly606_hw2" to each subdir
	# Syntax for "cp" can be referred to 
	# https://github.com/act-hydro/GLY606_2024/blob/main/in_class_practice/bash_practice/common_bash_comments.pdf

	# for example, if we want to copy ameriflux_static_fields.C1152.CA-Cbo.nc in "gly606_hw2" folder 
	#	to "model_run/CA-Cbo/static" folder
	#	we would use "cp gly606_hw2/ameriflux_static_fields.C1152.CA-Cbo.nc model_run/CA-Cbo/static"

	# 4.1. copy the static file 
	cp gly606_hw2/ameriflux_static_fields.C1152.${site}.nc model_run/${site}/static

	# 4.2. copy the initial condition file
	# note that given model run starts from <start_year>-01-01
	# the date for initial condition file should be previous year
	year_pre=$((start_year - 1))
	cp gly606_hw2/ameriflux_init_fields.C1152.${site}.${year_pre}-12-31_23-00-00.nc model_run/${site}/init

	# 4.3. copy the meteorological forcing file
	# use for-loop to loop through 5 days
	for day in {1..5}; do
		cp gly606_hw2/AMF_${site}_forcing_${start_year}-01-0${day}.nc model_run/${site}/forcing
	done
done
