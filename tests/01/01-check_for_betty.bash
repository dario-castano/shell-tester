#!/usr/bin/bash

# TITLE OF THE TEST
echo "Check if BETTY have no issues"

CMD="$BETTY $PROJECTDIR/*.c $PROJECTDIR/*.h"
echo "$CMD"

# wait a little bit
$SLEEP $SLEEPSECONDS
