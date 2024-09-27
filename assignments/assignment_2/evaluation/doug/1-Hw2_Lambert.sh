#!/bin/bash
  
echo
# HW2-1 Organizing folders

# Check if "model_run" folder exists. If not, make one.
if test -d model_run; then
    echo "Folder model_run ALREADY exists! Please remove it and rerun ( rm -r model_run )"
    echo
    exit
else
        echo "Welcome to HW2-1 Organizing folders"
        echo    
        echo "I just made the folder model_run."
        mkdir model_run
fi
echo
read -p "Press Enter to continue..."
# ls -R
echo # Here are the source files. I'm going to organize them... 
ls -R
echo
echo "Those are the files I'm organizing."
echo
read -p "Press Enter to continue..."
cd gly606_hw2
for line in `cat site_list.txt`; do
        IFS=","
        set -- $line
        site_id=$1
       date=$2
        unset IFSls
        mkdir ../model_run/$site_id
        mkdir ../model_run/$site_id/init
        mkdir ../model_run/$site_id/static
        mkdir ../model_run/$site_id/forcing
# cp ameriflux_init_fields.C1152.${site_id}.2006-12-31_23-00-00.nc #../model_run/${site_id}/init/
       year_pre=$((date - 1))
      f=ameriflux_init_fields.C1152.${site_id}.${year_pre}-12-31_23-00-00.nc
      d=../model_run/${site_id}/init/
     cp $f $d
# Now let's do the statics

        ff=ameriflux_static_fields.C1152.${site_id}.nc
       df=../model_run/${site_id}/static/
        cp $ff $df
# Now for the FORCING
    for day in {1..5}; do
        fg=AMF_${site_id}_forcing_${date}-01-0${day}.nc
        dg=../model_run/${site_id}/forcing/
        cp $fg $dg
    done
cd ../model_run
ls -R
cd ../gly606_hw2
echo
now=$(date)
echo ">>>>>>> FOLDERS FOR ${site_id} FILLED on $(date)."
echo
read -p "Press Enter to continue..."
done
echo "Done!"