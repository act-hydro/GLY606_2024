#!/bin/bash 

# ======================== #
# Overall comments #
# ======================== #
# Comment in bash scripts start with a hashtag.
# It is absolutely necessary to add a shibang (#!/bin/bash) on the top of the bash script!!

# ======================== #
# Start replacing site-specific info #
# ======================== #
# We will use "sed" command.
# We need to replace the site-specific information to unique placeholders.
# Step 1: Identify site-specific information
#         Site Name                  : US-SRG           --> use "REGION"
#         Date for initial cond file : 2009-12-31       --> use "DATE_IC"
#         Start date                 : 2010-01-01       --> use "START_DATE"
#         # of run days              : 365              --> use "RUN_DAYS"

# Rule: Do not overwrite the source files
source_file="ufs-land.namelist"
temp_file="ufs-land.namelist.template"

# Following line: 1) replace "US-SRG" using "REGION" and 2) create new template file
sed "s#US-SRG#REGION#g" ${source_file} > ${temp_file}

# The option "-i" means direct modification to the file
sed -i "s#2009-12-31#DATE_IC#g" ${temp_file}
sed -i "s#2010-01-01#START_DATE#g" ${temp_file}
sed -i "s#365#RUN_DAYS#g" ${temp_file}
