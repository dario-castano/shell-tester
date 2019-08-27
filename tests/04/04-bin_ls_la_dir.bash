#!/bin/bash
#
# run ls with arguments

tmp_file=".checker_tmp_file_$RANDOM"
tmp_filedir="/tmp"
tmp_filepath="$tmp_filedir/$tmp_file"
command="/bin/ls -la $tmp_filedir/"

# clean up
stop_shell
rm -f $tmp_filepath

# create a pseudo random file
touch $tmp_filepath
chmod 761 $tmp_filepath
# send commands
echo "$command" | $SHELL > $OUTPUTFILE 2> /dev/null &

# wait a little bit
$SLEEP $SLEEPSECONDS

# check the result
nmatch=`cat "$OUTPUTFILE" | grep "$tmp_file" | grep -c "rwxrw---x"`
if [ $nmatch -eq 1 ]; then
	   print_ok
	   TESTS_PASSED=$((TESTS_PASSED + 1))
	   
else
	   print_ko
	   TESTS_FAILED=$((TESTS_FAILED + 1))
	   
	   if [[ $SHOWERRORS -eq 1 ]]; then
	   	echo ""
	   	echo -e "[\033[31m************************\033[37m]"
	   	echo ">> Real output << "
	   	cat $OUTPUTFILE
	   	echo ">>**************<<"
	   	echo ""
	   	echo "> Expected output: "
	   	echo ""
	   	cat $tmp_file
	   	echo ">>**************<<"
	    echo -e "[\033[31m************************\033[37m]"
	   fi
fi

# clean up
stop_shell
rm -f $tmp_filepath
