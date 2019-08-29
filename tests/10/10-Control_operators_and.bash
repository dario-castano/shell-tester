#!/bin/bash
#
# Test and operator.


command="ls -l /bin && WRONG && ls -a /bin"
tmp_file="checker_tmp_file_$RANDOM"

# clean up
stop_shell
rm -f $tmp_file

# create a pseudo random file
touch $tmp_file
# run command
echo "$command" | $HSHELL > $OUTPUTFILE 2> /dev/null &
echo "$command" | $OSHELL > $tmp_file 2> /dev/null &
# wait a little bit
$SLEEP $SLEEPSECONDS
# check the result
nmatch=`diff $OUTPUTFILE $tmp_file | wc -l`
if [ $nmatch -eq 0 ]; then
	   print_ok
	   TESTS_PASSED=$((TESTS_PASSED + 1))
else
	   print_ko
	   TESTS_FAILED=$((TESTS_FAILED + 1))
	   if [[ $SHOWERRORS -eq 1 ]]; then
	   	echo ""
	   	echo -e "[\033[31m************************\033[37m]"
	   	echo ">> Real output << "
	   	cat -e $OUTPUTFILE
	   	echo ">>**************<<"
	   	echo ""
	   	echo "> Expected output: "
	   	cat -e $tmp_file
	   	echo ">>**************<<"
	    echo -e "[\033[31m************************\033[37m]"
	   fi
fi

# clean up
stop_shell
rm -f $tmp_file
