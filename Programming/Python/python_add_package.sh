#!/bin/bash

# In order to use it, get the complete path of the directory with the package
# and do sh python_add_package.sh "path1" "path2" ... this will link the
# directories to /usr/lib/pythonX.Y/site-packages automatically

###############################################################################
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
echo "This is 'python_add_package.sh', creates a link at '/usr/lib/pythonX.Y' in order to import packages from site-packages directly. Made by Daniel Ríos Linares (c) 2018 under GNU GPLv3, hope you find it useful."
while true; do
    read -p "Continue? (y/n) " ans
    case $ans in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "(y/n) please -.-\"";;
    esac
done
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
###############################################################################

if [ "$EUID" -ne 0 ]
    then
    echo "ERROR: run as root (sudo) required for writing into /usr/lib/"
    echo "Finished! run as root (sudo)"
    exit
fi

###############################################################################

echo "1) Moving to working directory (/usr/lib/)"
cd /usr/lib/
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "2) Detecting all python versions"
dirs=( $(find . -maxdepth 1 -type d -printf '%P\n') )
pydirs=()
for dir in "${dirs[@]}"; do
	if [[ $dir = *"python"* ]] ; then
		pydirs+=($dir)
	fi
done
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "3) Now select what python version are you interested in..."
i=0
for dir in "${pydirs[@]}" ; do
	echo "   $((i++)). $dir"
done
read -p "   Insert number " ans
echo "   You have selected $ans. ${pydirs[$ans]}"
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "4) This action will remove older versions"
while true; do
    read -p "Continue? (y/n) " ans
    case $ans in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "(y/n) please -.-\"";;
    esac
done
for file in "$@" ; do
	package=${file##*/}
	rm -rf "/usr/lib/${pydirs[$ans]}/site-packages/$package"
done
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "5) This action will create new entries"
while true; do
    read -p "Continue? (y/n) " ans
    case $ans in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "(y/n) please -.-\"";;
    esac
done
for file in "$@" ; do
	package=${file##*/}
	ln -s $file "/usr/lib/${pydirs[$ans]}/site-packages/$package"
done
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "Finished! Check /usr/lib/${pydirs[$ans]}/site-packages and import from everywhere"

exit
