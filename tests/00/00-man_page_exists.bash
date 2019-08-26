#!/usr/bin/bash

# TITLE OF THE TEST
echo "Check if the MAN page exists"

FILENAME="man_1_simple_shell"
FULLNAME="$PROJECTDIR/$FILENAME"

# wait a little bit
$SLEEP $SLEEPSECONDS

if [ -f "$FULLNAME" ];
then
    print_ok
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_ko
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi