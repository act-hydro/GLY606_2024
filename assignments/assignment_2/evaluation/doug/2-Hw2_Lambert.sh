#!/bin/bash 

# ======================== #
# Start replacing site-specific info with "sed" command.

# We need to replace the site-specific information to unique placeholders.
# Identify site-specific information
#         Site Name                  : US-SRG           --> use "REGION"
#         Date for initial cond file : 2009-12-31       --> use "DATE_IC"
#         Start date                 : 2010-01-01       --> use "START_DATE"
#         # of run days              : 365              --> use "RUN_DAYS"

# Get to the right place
cd gly606_hw2
#
# Protect the source files!
source_file="ufs-land.namelist.US-SRG"
temp_file="ufs-land.namelist.template"
# >>>>>>>>>>>
# This also seems to overwrite the existing template file, which for now is convenient for me.
# <<<<<<<<<<

# Following line: 1) replace "US-SRG" using "REGION" and 2) create new template file
# Replace specific parameters from US-SRG file to generic variables, AND
# ...move everything from the source file to the tempfile at the same time!

sed "s#US-SRG#REGION#g" ${source_file} > ${temp_file}

# The option "-i" means direct modification to the file
sed -i "s#2009-12-31#DATE_IC#g" ${temp_file}
sed -i "s#2010-01-01#START_DATE#g" ${temp_file}
sed -i "s#365#RUN_DAYS#g" ${temp_file}
#
echo
# cat ${temp_file} 
echo "We have genericized 4 variables in the US-SRG file into ${temp_file}!"
echo
read -p "Press Enter to continue..."
#
cat ${temp_file}
echo
echo "You can inspect the new template file above."
echo
read -p "Press Enter to continue..."
#
#
# Define the targeted output folder
odir="../config/"

# check whether the targeted output folder exists
# if this folder does not exist, create it
if [ ! -f ${odir} ]; then
	mkdir ${odir}
fi
############>>>>If it does exist, it does nothing, I guess?
#
# Create config files for each site, read the site information 
#
for line in `cat ./spinup_config.ameriflux_site.MDS.subset.csv`; do
	
	# Split the strings by comma ","
	IFS=",";
	set -- $line
	site_id=$1
	date_ic=$2
	start_date=$3
	run_days=$4
	unset IFS
	
	# print information for each site
	echo "Site ID     :"    $site_id
	echo "IC date     :"    $date_ic
	echo "Start date  :"    $start_date
	echo "# of days   :"    $run_days
    echo
	
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
echo "We made 10 configuration files with the above parameters."
echo
read -p "Here are the 10 file names in the config file:"
cd ../config/
ls -R
echo
echo "That is all!"
echo
