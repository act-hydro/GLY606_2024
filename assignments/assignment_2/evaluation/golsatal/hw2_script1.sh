#!/bin/bash


#sites=("CA-Cbo" "US-MMS" "US-Ho2" "US-Var" "US-Ton" "US-Ne1" "US-NR1" "US-Me2" "US-Wkg" "US-ARM")

#for site in "${sites[@]}"; do
 #   mkdir "model_run/$site"
#done

#for site in "${sites[@]}"; do
   # mkdir "model_run/$site/forcing"
  #  mkdir "model_run/$site/init"
 #   mkdir "model_run/$site/static"
#done



SITE_LIST="gly606_hw2/site_list.txt"

while IFS=',' read -r site_id year_start; do
    
    year_pre=$((year_start - 1))

    
    cp "gly606_hw2/ameriflux_init_fields.C1152.${site_id}.${year_pre}-12-31_23-00-00.nc" "model_run/${site_id}/init"

   
    cp "gly606_hw2/ameriflux_static_fields.C1152.${site_id}.nc" "model_run/${site_id}/static"

    
    for day in {1..5}; do
        # formating number of day with initial zero
        formatted_day=$(printf "%02d" $day)
        cp "gly606_hw2/AMF_${site_id}_forcing_${year_start}-01-${formatted_day}.nc" "model_run/${site_id}/forcing"
    done
done < "$SITE_LIST"

