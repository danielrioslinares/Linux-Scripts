#!/bin/bash

###############################################################################
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
echo "This is 'plasmashell2default.sh', when you want KDE to back to default run it and you'll get a clean desktop environment one more time. Made by Daniel Ríos Linares (c) 2018 under GNU GPLv3, hope you find it useful."
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

echo "1) Kill process"
kquitapp plasmashell
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "2) Wait 5 second. Be patient..."
sleep 5s
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "3) Removing cache of plasmashell"
rm -rf $HOME/.cache/plasmashell
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "4) Moving ~/.config/kde4 to ~/.config/kde4_old (if you want to go back)"
mv $HOME/.config/kde4 $HOME/.config/kde4_old
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "5) Done! restarting plasmashell"
plasmashell &
eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo

###############################################################################

echo "Finished! After reboot check the frequency range by typing 'cpupower frequency-info'"

exit
