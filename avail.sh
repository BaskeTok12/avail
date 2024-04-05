#!/bin/bash
echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/F1rstCap1tal/Logo/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

function install_avail_dependencies {
    sudo apt update && sudo apt upgrade -y
    sudo apt full-upgrade -y
}

function install_avail {
    curl -sL https://get.avail.sh | bash
}


function main {
    install_avail_dependencies
    install_avail
}

main