#!/bin/bash
#
# check if the getline function was used by using ltrace

command="/bin/ls"

# clean up
stop_shell
rm -f $tmp_file

# send commands
echo "$command" | $LTRACE -bc -o $LTRACEOUTPUTFILE $HSHELL > $OUTPUTFILE 2> /dev/null &


# check the result
let nmatch=`cat $LTRACEOUTPUTFILE | grep getline | wc -l`
if [ $nmatch -ge 1 ]; then
   	   print_ko
	   TESTS_FAILED=$((TESTS_FAILED + 1))

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
else
   print_ok
   TESTS_PASSED=$((TESTS_PASSED + 1))
fi

# clean up
stop_shell
rm -f $tmp_file
