#!/bin/bash
[ -f /usr/local/bin/catstep ] && echo "check" || git clone https://github.com/flyingrhinonz/catstep && cd catstep.git/ && sudo install -m 755 catstep -t /usr/local/bin/
dpkg -s htop && echo "check" || sudo apt install htop
dpkg -s bpytop && echo "check" || sudo apt install bpytop
dpkg -s whiptail && echo "check" || sudo apt install whiptail
sleep 3
PASS="123456"
#CMNT1: Problem with char being pre imput, find way to fix (Note by Panzer)
Bpytop="Bpytop"
Htop="Htop"
mopres=
#RefToCMNT1: I think it has something to do with this if statement but im not too sure (Note by Panzer)
if (whiptail --passwordbox "Enter password"  20 40 == PASS);then
    sleep 2
    $(mopres)="whiptail --menu "choose system to run" 20 40 3 \ Bpytop "must be in fullscreen" \ Htop \ exit"
else
#CMNT2: Find a way to restart the program in place of this. Maybe put it in a function to be called on? (Note by Panzer)
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
