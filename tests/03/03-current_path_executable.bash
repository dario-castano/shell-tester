#!/bin/bash
#
# check exit status after passing just spaces

command="./ls"
tmp_file="testing_custom_$RANDOM"
tmp_file2="testing_real_$RANDOM"

# create a pseudo random file
touch $tmp_file
# send commands
echo "$command" | $HSHELL > $tmp_file 2> /dev/null &
let tmp_exit=`echo $?`

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
if [ $tmp_exit -eq 0 ]; then
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
