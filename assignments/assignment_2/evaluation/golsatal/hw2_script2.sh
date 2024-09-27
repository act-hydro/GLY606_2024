#!/bin/bash 

source_file="gly606_hw2/ufs-land.namelist.US-SRG"
temp_file="ufs-land.namelist.template"

sed "s#US-SRG#REGION#g" ${source_file} > ${temp_file}
sed -i "s#2009-12-31#DATE_IC#g" ${temp_file}
sed -i "s#2010-01-01#START_DATE#g" ${temp_file}
sed -i "s#365#RUN_DAYS#g" ${temp_file}


odir="./model_run/"

if [ ! -d "${odir}" ]; then
    mkdir "${odir}"
fi

while IFS=',' read -r site_id year_start; do
    init_date_time=$(date -d "$year_start-01-01 -1 hour" '+%Y-%m-%d_%H-%M-%S')
    start_date="${year_start}-01-01"
    num_run_days="5"

    echo "Site ID     :" $site_id
    echo "IC date     :" $init_date_time
    echo "Start date  :" $start_date
    echo "# of days   :" $num_run_days

    temp_file="ufs-land.namelist.template"
    site_dir="${odir}${site_id}/"
    mkdir -p "${site_dir}"

    site_file="${site_dir}ufs-land.namelist.${site_id}"

    sed "s#REGION#${site_id}#g" "$temp_file" > "$site_file"
    sed -i "s#DATE_IC#${init_date_time}#g" "$site_file"
    sed -i "s#START_DATE#${start_date}#g" "$site_file"
    sed -i "s#RUN_DAYS#${num_run_days}#g" "$site_file"

done < "gly606_hw2/site_list.txt"

