#!/bin/bash

mkdir model_run

for line in $(cat site_list.txt); do
    IFS=','
    set -- $line
    site_id=$1
    year=$2
    site_dir="model_run/$site_id"

    mkdir -p "$site_dir/forcing" "$site_dir/init" "$site_dir/static"
    
    cp *"AMF_${site_id}_forcing_"* "$site_dir/forcing/"
    cp *"ameriflux_init_fields.C1152.${site_id}.*.nc" "$site_dir/init/"
    cp *"ameriflux_static_fields.C1152.${site_id}.nc" "$site_dir/static/"
done







