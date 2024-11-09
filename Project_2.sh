#!/bin/bash

#ensure that the script is being run as root
if [[ $EUID -ne 0 ]]; then
        echo " Script must be run as a root, use sudo to run the script properly"
        exit 1
fi

#prompt the user for a username for the new user being created and save it for future use
echo "enter a username"
read username

#check if the username already exists
if grep -q "$username:" /etc/passwd; then

    echo "username already in use, try another one."
    exit 1
fi

#using the newly inputed username make a direction catered to them
mkdir /home/$username

#Prompt the user to create a password and store it for future use
echo "enter a password"
read password


#Create a New User ID that will auto incriment by 1 for each new user within the right parameters (between 1000-65535)
New_UID=$(awk -F: '($3>=1000)&&($3<65534){if(max<$3)max=$3}END{print max+1}' /etc/passwd)

#Create a new group ID thats auto incrimated by 1 within the same paramters as the user ID
New_GID=$(awk -F: '($4>=1000)&&($4<65534){if(max<$4)max=$4}END{print max+1}' /etc/passwd)

# append the new group to /etc/group (use x as a placeholder for the password to show that its stored in a different file
echo "$username:x:$New_GID:" >> /etc/group

# add the new user to /etc/passwd
echo "$username:x:$New_UID:$New_GID::/$username:/bin/bash" >> /etc/passwd

# add the new user to /etc/shadow
echo "$username:$password" >> /etc/shadow

# set ownership and permissions for the user's home directory
chown $username:$username /home/$username
chmod 755 /home/$username

# confirm the creation of the new user
echo "User $username has been created!"