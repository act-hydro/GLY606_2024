#!/bin/bash

# Section 1: calculation for integers

# When comparing integer numbers
# The syntax is simpler

p=1000
q=500
e=400
Ds=100

water_balance=$(($p-$q-$e-$Ds))
echo Water Balance Error in Example 1 is $water_balance
echo Start if-statement

if [[ $water_balance -eq 0 ]]; then
	echo Water is balanced
elif [[ $water_balance -gt 0 ]]; then
	echo Positive error exists!
else
	echo Negative error exists!
fi

echo ""
echo ""

# Section 2: Calculation for floating numbers

# When comparing floating numbers
# the syntax can become a bit complicated...
p_2=1000.01
q_2=499.99
e_2=400.01
Ds_2=99.98

 # 1. The syntax to do calculations for floating numbers are different
# 2. `bc` command is used for command line calculator.
# 3. `|` is called pipe. It passes the output of a previous command to the input of the next one.
water_balance_2=$(echo "${p_2}-${q_2}-${e_2}-${Ds_2}" | bc)

# print the water balance error
echo Water Balance Error in Example 2 is $water_balance_2

# calculate the absolute value of water balance error
abs_water_balance_2=${water_balance_2#-}

# assign a threshold of error
threshold=0.1

if (( $(echo "$abs_water_balance_2 <= $threshold" | bc -l) )); then
        echo Water balance error is $water_balance_2
	echo The error is smaller than the error threshold $threshold
	echo Water is balanced
elif (( $(echo "$water_balance_2 > $threshold" | bc -l) )); then
        echo Positive error exists!
	echo The error is $water_balance_2
else
        echo Negative error exists!
        echo The error is $water_balance_2
fi


