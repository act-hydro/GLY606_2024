#!/bin/bash


input_file="gly606_hw2/ameriflux_water_flux.txt"

while IFS=',' read -r site precipitation runoff evaporation storage_change; do
    
    expected_precip=$(echo "$runoff + $evaporation + $storage_change" | bc)
    balance_error=$(echo "$precipitation - $expected_precip" | bc)
    
  
    abs_balance_error=${balance_error#-}

   
    threshold=0.1

    
    if (( $(echo "$abs_balance_error <= $threshold" | bc -l) )); then
        echo "Site ID: $site"
        echo "Water is balanced within the threshold."
    elif (( $(echo "$balance_error > $threshold" | bc -l) )); then
        echo "Site ID: $site"
        echo "Positive error exists! Water Balance Error: $balance_error mm"
    else
        echo "Site ID: $site"
        echo "Negative error exists! Water Balance Error: $balance_error mm"
    fi

done < "$input_file"

