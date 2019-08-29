#!/usr/bin/env bash

# Checks if your shell handle the ; command separator

tmp_file="testing_custom_$RANDOM"
tmp_file2="testing_real_$RANDOM"

command="echo $PATH ; echo $HOME ; echo $USER ; echo $PWD"

# clean up
stop_shell
rm -f $tmp_file
rm -f $tmp_file2

# create a pseudo random file
touch $tmp_file
touch $tmp_file2

# send commands
echo "$command" | $SHELL > $tmp_file 2> /dev/null &
echo "$command" | /bin/sh > $tmp_file2 2> /dev/null &

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
nmatch=`grep -c "$tmp_file" "$tmp_file2"`
if [ $nmatch -eq 0 ]; then
	   print_ok
	   TEST_PASSED=$((TEST_PASSED + 1))
else
	   print_ko
	   TEST_FAILED=$((TEST_FAILED + 1))
fi

# clean up
stop_shell
rm -f $tmp_file
rm -f $tmp_file2
