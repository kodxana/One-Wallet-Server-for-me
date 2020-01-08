#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

function advancedMenu() {
    ADVSEL=$(whiptail --title "Wallet Server Installer" --fb --menu "Choose an option" 15 60 4 \
        "1" "Install LBRYcrd" \
        "2" "Install LBRY-SDK" \
        "3" "Start Wallet Server" \
        "4" "Exit" 3>&1 1>&2 2>&3)
    case $ADVSEL in
        1)
            LBRYcrd
        ;;
        2)
            echo "Option 2"
            whiptail --title "Option 1" --msgbox "You chose option 2. Exit status $?" 8 45
        ;;
        3)
            echo "Option 3"
            whiptail --title "Option 1" --msgbox "You chose option 3. Exit status $?" 8 45
        ;;
       4)
           echo "Test 3"
        ;;
    esac
}


function LBRYcrd() {

 curl -s https://api.github.com/repos/lbryio/lbrycrd/releases/latest \
 | grep "lbrycrd-linux-.*.zip" \
 | cut -d : -f 2,3 \
 | tr -d \" \
 | wget -qi - 
 unzip lbrycrd-linux-*
 rm lbrycrd-linux-*
 mkdir ~/.lbrycrd/
 touch ~/.lbrycrd/lbrycrd.conf
 
PASSWORD=$(whiptail --passwordbox "Please enter password you wan to use for LBRYcrd" 8 78 --title "LBRYcrd Password Setup" 3>&1 1>&2 2>&3)
                                                                        # A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Password is now saved in config file"
else
    echo "User selected Cancel."
fi

echo "rpcuser=lbry" > ~/.lbrycrd/lbrycrd.conf
echo "deamon=1" >> ~/.lbrycrd/lbrycrd.conf
echo "server=1" >> ~/.lbrycrd/lbrycrd.conf
echo "txindex=1" >> ~/.lbrycrd/lbrycrd.conf
echo "rpcpassword=$PASSWORD" >> ~/.lbrycrd/lbrycrd.conf


}



advancedMenu
