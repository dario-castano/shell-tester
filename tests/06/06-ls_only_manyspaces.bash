#!/bin/bash
#
# test simple command ls by doing it a lot of times and putting a lot of spaces between it

command="ls
			ls
ls
				ls
	ls
							ls
									ls
ls			
					ls
							ls
				ls"
tmp_file="testing_custom_tmp_file_$RANDOM"

# create a pseudo random file
touch $tmp_file
# run command
echo "$command" | $HSHELL > $OUTPUTFILE 2> /dev/null &

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
nmatch=`cat $OUTPUTFILE | grep -c "$tmp_file"`
# check the results
if [ $nmatch -eq 11 ]; then
		print_ok
		TEST_PASSED=$((TEST_PASSED + 1))
else
		print_ko
		TEST_FAILED=$((TEST_FAILED + 1))
fi

# clean up
stop_shell
rm -f $tmp_file
