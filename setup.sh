#!/usr/bin/bash

##################################
# HOLBERTON'S SHELL-TESTER SETUP #
##################################

# Delete old config
sed -i '/PROJECTDIR/d' config
sed -i '/HSHELL/d' config
sed -i '/EXPECT/d' config
sed -i '/LTRACE/d' config

function check_installed {
    NAME=$1
    LOCATION=$2
    UPCASE=`echo ${NAME^^}`
    ANSWER=""
    if test -z "$LOCATION"
    then
        echo "-> Not installed."
        echo "$NAME is required to run some tests"
        while [ "$ANSWER" != "y" ] && [ "$ANSWER" != "n" ];
        do
            read -n 1 -p "Do you want to install $NAME (y/n)?" ANSWER
            echo ""
        done

        if [ "$ANSWER" == "y" ];
        then
            sudo apt install "$NAME"
            LOCATION=`which ${NAME}`
            echo "$UPCASE=\"$LOCATION\"" >> config
        else
            echo "Expect not installed"
        fi
    else
        echo "-> Installed."
        LOCATION=`which ${NAME}`
        echo "$UPCASE=\"$LOCATION\"" >> config
    fi
}

echo "--------------------------------------"
echo "--- Holberton's shell-tester setup ---"
echo "--------------------------------------"
echo ""

# Check if expect is installed 
echo "Checking if expect is installed ..."
check_installed "expect" "$(which expect)"
echo ""

# Checking if ltrace is installed
echo "Checking if ltrace is installed ..."
check_installed "ltrace" "$(which ltrace)"
echo ""

# Prompt for PROJECTDIR
echo "Please type here the absolute path where your project files are located:"
read PROJECTDIR
echo "PROJECTDIR=\"$PROJECTDIR\"" >> config

# Prompt for HSHELL
echo "Please type here the absolute path of your shell executable:"
read HSHELL
echo "HSHELL=\"$HSHELL\"" >> config

# Install jp2a
echo "Installing jp2a..."
sudo apt install -y jp2a

echo "DONE."
echo "You can run the checker with ./runchecker"