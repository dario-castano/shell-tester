#!/bin/bash
if [[ $valgrind_check -eq 1 ]]; then
	trash="/dev/null"
	#HSHELL="../../../../HolbertonRepos/bash_stuff/simple_shell/V3/h"
	#HSHELL2="../../../../Desktop/a.out"

	# execute the prog and putting output to out file
	valgrind --leak-check=full ./$SHELL < /bin/ls > test_ing.txt 2>&1


	# cheking for patters that indicate err
	grep -q "in use at exit: 0 bytes in 0 blocks" "test_ing.txt"
	grep "in use at exit: 0 bytes in 0 blocks" "test_ing.txt" > output.txt
	

	# grab exit status of grep (0 if all good ,1 if not)
	ret=$?

	# wait a little bit
	$SLEEP $SLEEPSECONDS

	# write appropriate message as per return status value
	# check the result
	if [[ $ret -eq 0 ]]; then
		   print_ok
		   TESTS_PASSED=$((TESTS_PASSED + 1))
		   
	else
		   print_ko
		   TESTS_FAILED=$((TESTS_FAILED + 1))
		   
		   if [[ $SHOWERRORS -eq 1 ]]; then
		   	echo ""
		   	echo -e "[\033[31m************************\033[37m]"
		   	echo ">> Real output << "
		   	cat test_ing.txt
		   	echo ">>**************<<"
		   	echo ""
		   	echo "> Expected output: "
		   	echo "definitely lost: 0 bytes in 0 blocks"
		   	echo ">>**************<<"
		    echo -e "[\033[31m************************\033[37m]"
		   fi
	fi

	# clean up
	stop_shell
	rm -f test_ing.txt
	rm -f output.txt
else
	echo "no valgrind check... ;)"
fi

#((ret == 0)) && echo "No leaks." || echo "Uh oh, Valgrind didn't pass"

# return the exit status of testMem
#exit $ret