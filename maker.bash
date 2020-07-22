#!/bin/bash

function preparation () {
    blue_log "Prease wait..."
    mkdir makerfile
    touch variable
}
preparation
echo "Welcome to Font Installer Maker!!"
echo "First, please choose your installer type."
echo "1 ) Simple installer" 
echo "2 ) Simple installer and dpkg installer"
echo "3 ) exit"
printf "Please enter mode number. : "
read TYPE 
echo "Okay"
read -p "Please enter the name of the font. :" fontname
read -p "Please enter the URL of the zip file that contains the font." downloadfile
read -p "Please enter where the font file is located in the zip file. :" dir
zipname="${fontname}.zip"
echo "#!/bin/bash" > ./variable
echo fontname="${fontname}" > ./variable
echo downloadfile="${downloadfile}" > ./variable
echo dir="${dir}" > ./variable
echo zipname="${zipname}" > ./variable
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
    mkdir deb
    cd deb
    mkdir "./${fontnane}"
    cd "./${fontname}"
    mkdir ./DEBIAN
    cd ./DEBIAN
    wget https://raw.githubusercontent.com/NSK-1010/Font-Installer-Maker-Scripts/master/control-base
    mode2_deb
}
function mode2_deb () {
    read -p "Please enter a package name.:" DPKGNAME
    touch description
    echo "Description: [Short Description]" > ./description
    echo "[Short Description]" > ./description
    nano ./description
    touch control
    echo "Package: ${DPKGNAME}" > ./control
    cat ./control-base ./description > ./control
    rm ./control-base
}
function mode2_process () {
    mode2_download1
    mode2_download2
    cd ../../..
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
    read -p "Do you want to open nano for advanced editing? (Y/n) :" YN
    if [[ ${YN} = [yY] ]]; then
      nano ./install.sh
    else
      return 0;
    fi
}
function mode2_nano () {
    read -n 1 -p "Do you want to open nano for advanced editing? (y/n) :" YN1
    if [[ ${YN} = [yY] ]]; then
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
