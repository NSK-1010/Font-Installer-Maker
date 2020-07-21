#!/bin/bash

function preparation () {
    blue_log "Prease wait..."
    mkdir makerfile
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/variable
}
preparation
echo "Welcome to Font Installer Maker!!"
echo "Please enter your font information first."
nano ./variable
echo "Okay."
echo "Next, please choose your installer type."
echo "1 ) Simple installer" 
echo "2 ) Simple installer and dpkg installer"
echo "3 ) exit"
printf "Please enter mode number. : "
read TYPE 
echo "Okay"
function mode1_download () {
    red_log "Downloading file."
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/mode1
}
function mode1_process () {
    mode1_download
    blue_log "Processing file."
    touch ./install.sh
    cat ./variable ./mode1 > install.sh
    rm ./variable
    rm ./mode1
}
function mode2_download1 () {
    blue_log "Downloading file."
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/mode1
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/mode2-1
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/mode2-2
}
function mode2_download2 () {
    read -p "Please enter the name of the font. :" FONTNAME
    mkdir deb
    cd deb
    mkdir "./${FONTNAME}"
    cd "./${FONTNAME}"
    mkdir ./DEBIAN
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/control
}
function mode2_process () {
    mode2_download1
    mode2_download2
    blue_log "Processing file."
    touch ./install.sh
    touch ./install-deb.sh
    touch ./build-deb.sh
    cat ./variable ./mode1 > install.sh
    cat ./variable ./mode2-1 > install-deb.sh
    cat ./variable ./mode2-2 > build-deb.sh
    rm ./variable
    rm ./mode1
    rm ./mode2-1
    rm ./mode2-1
}
function mode1_nano () {
    read -p "Do you want to open nano for advanced editing? (y/n) :" YN
    if [ "${YN}" = "y" ]; then
      nano ./install.sh
    else
      return 0;
    fi
}
function mode2_nano () {
    read -p "Do you want to open nano for advanced editing? (y/n) :" YN1
    if [ "${YN1}" = "y" ]; then
      nano ./install.sh
      nano ./install-deb.sh
      nano ./build.sh
    else
      return 0;
    fi
}
function mode1 () {
    mode1_process
    mode1_nano
}
function mode2 () {
    mode2_process
    mode2_nano
}
function error () {
    red_log "Enter the correct mode number."
    if [[ -z $argument ]]; then
        $0
    else
        how_to_use
    fi
}
case "$TYPE" in
	1 ) mode1  ;;
	2 ) mode2 ;;
        3 ) exit 0 ;;
        0 ) error ;;
	* ) error ;;
esac
