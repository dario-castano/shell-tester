#!/bin/bash
#
# 
command="env"
tmp_file="testing_custom_$RANDOM"
tmp_file2="testing_real_$RANDOM"
# create a pseudo random file
touch tmp_file
# send commands
echo "$command" | $HSHELL > tmp_file 2> /dev/null &
echo "$command" | $OSHELL > tmp_file2 2> /dev/null &
# wait a little bit
$SLEEP $SLEEPSECONDS
# check the result
grep -q "$PATH" tmp_file
# grab exit status of grep (0 if all good ,1 if not)
        ret=$?
        # wait a little bit
        $SLEEP $SLEEPSECONDS
        # write appropriate message as per return status value
        # check the result
        if [ $ret -eq "0" ]; then
                   print_ok
            TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_ko
            TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
        
        
# clean up
stop_shell
rm -f $tmp_file
rm -f $tmp_file2
