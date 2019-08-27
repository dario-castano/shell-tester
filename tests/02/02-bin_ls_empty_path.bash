#!/bin/bash
#
# Empty the PATH and check if /bin/ls still works

command="/bin/ls"
tmp_file="checker_tmp_file_$RANDOM"

# clean up
stop_shell
rm -f $tmp_file

# create a pseudo random file
touch $tmp_file
# empty PATH
OLDPATH="$PATH"
PATH=""
# send commands
$ECHO "$command" | $OSHELL > $OUTPUTFILE 2> $ERROROUTPUTFILE &

# put PATH back
PATH="$OLDPATH"

# wait a little bit
$SLEEP $SLEEPSECONDS

cat $ERROROUTPUTFILE

# check the result
nmatch=`$CAT $OUTPUTFILE | $GREP -c "$tmp_file"`
if [ $nmatch -eq 1 ]; then
    print_ok
else
    print_ko
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
$RM -f $tmp_file
