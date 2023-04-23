#!/bin/bash
[ -f /usr/local/bin/catstep ] && echo "check" || git clone https://github.com/flyingrhinonz/catstep && cd catstep.git/ && sudo install -m 755 catstep -t /usr/local/bin/
dpkg -s htop && echo "check" || sudo apt install htop
dpkg -s bpytop && echo "check" || sudo apt install bpytop
dpkg -s whiptail && echo "check" || sudo apt install whiptail
sleep 3
PASS="42297482"
Bpytop="Bpytop"
Htop="Htop"
mopres=
if (whiptail --passwordbox "Enter password"  20 40 == PASS);then
    sleep 2
    $(mopres)="whiptail --menu "choose system to run" 20 40 3 \ Bpytop "must be in fullscreen" \ Htop \ exit"
else
    echo "please restart the program to try again"
    sleep 3
    exit
fi
if [[ $mopres ==  $Bpytop ]]; then
    bpytop
else
    echo "please restart the program"
    sleep 3
    exit
fi
if [[ $mopres ==  $Htop ]]; then
    htop
else
    echo "please restart the program"
    sleep 3
    exit
fi