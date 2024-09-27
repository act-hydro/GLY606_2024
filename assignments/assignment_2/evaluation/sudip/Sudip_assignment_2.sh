#!/bin/bash

# ======================== #
# Step 1: Create a folder to save config files #
# ======================== #

odir="./config/"

if [ ! -d "${odir}" ]; then
    mkdir -p "${odir}"
fi

# ======================== #
# Step 2: Create config files for each site #
# ======================== #

for line in $(cat ./spinup_config.ameriflux_site.MDS.subset.csv); do
    IFS=","
    set -- $line
    site_id=$1
    date_ic=$2
    start_date=$3
    run_days=$5
    unset IFS
    
    echo "Site ID     : $site_id"
    echo "IC date     : $date_ic"
    echo "Start date  : $start_date"
    echo "# of days   : $run_days"
    
    temp_file="ufs-land.namelist.US-SRG"
    site_file="${odir}ufs-land.namelist.${site_id}"
    
    cp $temp_file $site_file
    
    sed -i "s#REGION#${site_id}#g" $site_file
    sed -i "s#DATE_IC#${date_ic}#g" $site_file
    sed -i "s#START_DATE#${start_date}#g" $site_file
    sed -i "s#RUN_DAYS#${run_days}#g" $site_file

done
