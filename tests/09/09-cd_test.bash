#!/bin/bash
#
# simple test with ls to check if the shell can find ls in the PATH

cd $LSDIR

grep -rq SIGINT

ret=$?

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result

if [[ $ret -eq 0 ]]; then
	   print_ok
   	   TESTS_PASSED=$((TESTS_PASSED + 1))
else
	  	print_ko
	   TESTS_FAILED=$((TESTS_FAILED + 1))
	   
fi

>/dev/null cd -

# clean up
stop_shell
rm -f $tmp_file
rm -f $tmp_file2
