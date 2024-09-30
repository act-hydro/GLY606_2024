#!/bin/bash

# Part 1: create template file using "gly606_hw2/ufs-land.namelist.US-SRG"
# Example script: https://github.com/act-hydro/GLY606_2024/blob/main/in_class_practice/bash_practice/1.create_config_template.sh

# Following site specific information needs to be replaced using unique place holders:
#	1) US-SRG - site_id
# 	2) 2009-12-31 - date for initial condition (please note that all model runs in our study starts from <start_year>-01-01
#	                so we only need to replace the year, which is (start_year-1))
#	3) 2010-01-01 - simulation start date (all model runs starts from <start_year>-01-01
#	                so we only need to replace the year, which is start_year
#	4) 365 - # of run days, here we only have forcings for 5 days, so this number needs to be replaced

# Define the name of template files
source_file="gly606_hw2/ufs-land.namelist.US-SRG"
temp_file="ufs-land.namelist.template"

# Following line: 1) replace "US-SRG" using "REGION" and 2) create new template file (use `sed`)
sed "s#US-SRG#REGION#g" ${source_file} > ${temp_file}

# The option "-i" means direct modification to the file
echo test1
sed -i "s#2009#IC_YEAR#g" ${temp_file}
sed -i "s#2010#START_YEAR#g" ${temp_file}
sed -i "s#365#RUN_DAYS#g" ${temp_file}
echo test2

# Part 2: generate configuration files for multiple sites 
# Example script: https://github.com/act-hydro/GLY606_2024/blob/main/in_class_practice/bash_practice/2.generate_config_for_multiple_site.sh

# We will need to replace the unique place holders using site specific information
#	1) site_id; 2) year for init condition; 3) start year; 4) # of run days 

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
	ic_year=$((start_year - 1))
	
	# Step 2: Define the name of configuration files for each site
	site_file="model_run/${site}/ufs-land.namelist.${site}"

	# Step 3: Use `sed` to replace the unique places holders with site specific information
	# Note: the # of run days is 5 in our test case (run_days=5)
	run_days=5
	sed "s#REGION#${site}#g" $temp_file > $site_file
	sed -i "s#IC_YEAR#${ic_year}#g" $site_file
	sed -i "s#START_YEAR#${start_year}#g" $site_file
	sed -i "s#RUN_DAYS#${run_days}#g" $site_file
done




