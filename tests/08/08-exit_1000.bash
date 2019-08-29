#!/bin/bash
#
# simple test with exit to check if the shell status is 98
	command="exit 1000"

	tmp_file="testing_custom_$RANDOM"
	tmp_file2="testing_real_$RANDOM"
# create a temporal file
	touch $tmp_file
# send commands
	echo "$command" | $HSHELL > $tmp_file 2>/dev/null
# variable to get status
	let ret_actual=$?
# print status
	echo "$ret_actual"
# send commands
	echo "$command" | $OSHELL > $tmp_file2 2>/dev/null
# get status
	let ret_exepected=$?
# status expected
	echo "$ret_exepected"

	#wait a little bit
	$SLEEP $SLEEPSECONDS
# check if the status is the expected
	if [[ $ret_actual -eq $ret_exepected ]]; then
		print_ok
		TEST_PASSED=$((TEST_PASSED+1))
	else
		print_ko
		TEST_FAILED=$((TEST_FAILED+1))
	fi

# clean up
	stop_shell
	rm -f $tmp_file
	rm -f $tmp_file2
