#!/bin/bash
#
# simple test with ls to check if the shell can find ls in the PATH

#
echo "Tests if /bin/ls shows the same files on sh and hsh"

command="/bin/ls"
tmp_file="testing_custom_$RANDOM"
tmp_file2="testing_real_$RANDOM"

# create a pseudo random file
touch $tmp_file
# send commands
echo "$command" | $OSHELL > $tmp_file 2> /dev/null &
echo "$command" | $HSHELL > $tmp_file2 2> /dev/null &

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result

if diff <(sort "$tmp_file") <(sort "$tmp_file2"); then
	   print_ok
	   TESTS_PASSED=$((TESTS_PASSED + 1))
else
	   print_ko
	   if [[ $SHOWERRORS -eq 1 ]]; then
	   	echo ""
	   	echo -e "[\033[31m************************\033[37m]"
	   	echo ">> Real output << "
	   	cat $tmp_file
	   	echo ">>**************<<"
	   	echo ""
	   	echo "> Expected output: "
	   	echo ""
	   	cat $tmp_file2
	   	echo ">>**************<<"
	    echo -e "[\033[31m************************\033[37m]"
	   fi
	   TESTS_FAILED=$((TESTS_FAILED + 1))
fi

# clean up
stop_shell

rm -f $tmp_file
rm -f $tmp_file2
