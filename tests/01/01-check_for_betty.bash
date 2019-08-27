#!/usr/bin/bash

# TITLE OF THE TEST
echo "Check if BETTY have no issues"

CMD="$BETTY $PROJECTDIR/*.c $PROJECTDIR/*.h"
$CMD > /dev/null 2> tmpfile

let ERRORS=`cat tmpfile | wc -l`

if [ "$ERRORS" -eq 0 ];
then
    print_ok
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    print_ko
    TESTS_FAILED=$((TESTS_FAILED + 1))
fi

rm tmpfile
