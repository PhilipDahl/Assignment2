#!/bin/bash

#ensure that script is run by root user by checking if user id is not equal to 0 then alert that root permissions are required and exit.
if [ "$(id -u)" -ne 0 ]; then
        echo "Script needs to be run as root, use sudo to execute"
        exit 1
fi

# The link to the necessary packages as a variable named packages
packages="/home/arch/2420-as2-starting-files/as2/packages"

# Notifying the begining of the script
echo "installing required packages..."

# A while loop that reads each line using IFS stating for each package found in the packages file use pacman to download them.
while IFS= read -r package; do
    if sudo pacman -S --noconfirm "$package"; then
            # if all packages download with no issue say succcess
            echo "Packages Successfully Installed!"
        else
            # otherwise state that the packages failed
            echo "Failed To Install Packages."
        fi
#end of script, perform this from the packages variable
done < "$packages"
echo "Process Completed."