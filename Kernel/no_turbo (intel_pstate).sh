#!/bin/bash

###############################################################################
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
echo "This is 'no_turbo (intel_pstate).sh', creates a file named '50-cpu-custom.rules' at '/etc/udev/rules.d/' in order to disable intel_pstate overclock at startup. Made by Daniel Ríos Linares (c) 2018 under GNU GPLv3, hope you find it useful."
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
    echo "ERROR: run as root (sudo) required for writing into /etc/udev/rules.d/"
    echo "Finished! run as root (sudo)"
    exit
fi

###############################################################################

echo "1) Generating startup rule"
echo "KERNEL==\"cpu\",RUN+=\"/bin/sh -c 'echo -n 1 > /sys/devices/system/cpu/intel_pstate/no_turbo'\"" > /etc/udev/rules.d/50-cpu-custom.rules
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "Finished! After reboot check the frequency range by typing 'cpupower frequency-info'"

exit
