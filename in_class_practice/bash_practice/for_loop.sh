#!/bin/bash

# EXAMPLE 1: starter code for for-loop
# following is an example for looping through
# numbers 1 to 5, and print the number to terminal

# big bracket {<start_number>..<end_number>} creates
# a list of numbers between <start_number> and 
# <end_number>

# A for loop starts with "for" and ends with "done"
for i in {1..5}; do
	echo $i; 
done


# EXAMPLE 2: advanced code to loop through a file
# This is a line of the file:
# CA-Cbo,2010-12-31,2011-01-01,2011-12-31,365
# 1st element: site_id
# 2nd element: init_date
# 3rd element: start_date
# 4th element: end_date
# 5th element: number of run days

# we want to 1) split every element in one line by comma
#            2) assign the element value to variables

# `cat`: loop through everyline in file
# "spinup_config.ameriflux_site.MDS.subset.csv"
# and assign the line to variable "line"!

for line in `cat spinup_config.ameriflux_site.MDS.subset.csv`; do
	echo $line          # print each line
	echo  		    # print a blank line
        IFS=","             # define the deliminator, split by comma
	set -- $line 
	site_id=$1          # assign the first element in a line to variable "site_id"
	init_date=$2        # assign the second element in a line to variable "init_date"
	start_date=$3
	num_run_days=$5
	unset IFS           # we need to unset the deliminator
	echo "site name is:" $site_id
	echo "start date is:" $start_date	
done
