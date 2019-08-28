#!/bin/bash

	command="ls"
        touch test_file

        # execute the prog and putting output to out file
        valgrind --leak-check=full --log-file=test_file echo "$command" | ./hsh 2>&1

        # cheking for patters that indicate err
        grep -q "in use at exit: 0 bytes in 0 blocks" test_file

        # grab exit status of grep (0 if all good ,1 if not)
        ret=$?

        # wait a little bit
        $SLEEP $SLEEPSECONDS

        # write appropriate message as per return status value
        # check the result
        if [ $ret -eq "0" ]; then
                   echo ok
	else
		echo bad

	fi
