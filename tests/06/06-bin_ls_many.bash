#!/bin/bash
#
# test simple command /bin/ls

command="/bin/ls
/bin/ls
ls
/bin/ls
ls
ls
/bin/ls"
tmp_file="testing_tmp_file_$RANDOM"

# create a pseudo random file
touch $tmp_file
# run command
echo "$command" | $HSHELL > $OUTPUTFILE 2> /dev/null &

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
nmatch=`cat $OUTPUTFILE | grep -c "$tmp_file"`
# check the results
if [ $nmatch -eq 7 ]; then
		print_ok
		TEST_PASSED=$((TEST_PASSED + 1))
else
		print_ko
		TEST_FAILED=$((TEST_FAILED + 1))
fi

# clean up
stop_shell
rm -f $tmp_file
