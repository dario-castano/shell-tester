#!/bin/bash
#
# run a mix of ls and /bin/ls many times

command="ls
ls
ls
/bin/ls
ls
ls
ls
/bin/ls
ls
ls"
tmp_file="checker_tmp_file_$RANDOM"

# clean up
stop_shell
rm -f $tmp_file

# create a pseudo random file
touch $tmp_file
# send commands
echo "$command" | $HSHELL > $OUTPUTFILE 2> /dev/null &

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
nmatch=`cat $OUTPUTFILE | grep -c "$tmp_file"`
if [ $nmatch -eq 10 ]; then
	   print_ok
	   TESTS_PASSED=$((TESTS_PASSED + 1))
	   
else
	   print_ko
	   TESTS_FAILED=$((TESTS_FAILED + 1))
fi

# clean up
stop_shell
rm -f $tmp_file
