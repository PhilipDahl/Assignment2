#!/bin/bash

#ensure that the file is being run in elevated privelleges
if [[ $EUID -ne 0 ]]; then
        echo "Script must be run as root, or use sudo."
        exit 1
fi

#script to run the symbolic link creator file
./Project1_symbolic_links.sh
#script to run the package installer
./Project1_package_installer.sh