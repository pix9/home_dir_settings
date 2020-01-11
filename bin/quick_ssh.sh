#!/bin/bash
# Name :- Pushkar Madan
# Email :- pushkarmadan@yahoo.com
# Date :- 12th January 2020
# Purpose :- To enable quick connecting to remote system using IP octates / short codes.
# Milestone :- None
# Last Modified :- 12th January 2020
# Reason To Modify :- Creation
# Note :-	Execuion logic is based out of symlink created and is residing inside "${HOME}/bin" directory.
#			Considering you want to connect to ip "192.168.36.128" as "student" user from subnet "192.168.36.0/24" you can quickly connect using below short command.
#			$ 36 128 student ( SYNOPSIS :- $ 36 ${LAST_OCTATE} ${SSH_USER} )
# 			For above command to work you need subnet handeling for respective subnet along with symlink by name of 3rd octate or short codes.
#

LAST_OCT=${1}
DEFAULT_SSH_USER="${USER}"
SCRIPT_PATH="${HOME}/bin"

### Setting default ssh Keys.
if [ -z  "${HOME}/.ssh/id_rsa.pub" ];then
	DEFAULT_PUB_KEY="/dev/null" ### Avoid errors if defaults are missing.
else
	DEFAULT_PUB_KEY="${HOME}/.ssh/id_rsa.pub"
fi

### Considering we are likely to deal with class C subnets and IP address.
if [ ${LAST_OCT} -le 254  -a ${LAST_OCT} -ne 0 ];then
	   > /dev/null
else
	echo "Kidnly provide proper octate."
	exit 1
fi

### Subnet Handeling for 192.168.122.0/24
if [ ${0}  == "${SCRIPT_PATH}/122" ];then
	NID=192.168.122
	DEFAULT_SSH_USER="student"
	PUB_KEY="${DEFAULT_PUB_KEY}" ### if you have multiple keys you can changes them based on respective networks subnets.
fi

### If no username is passed consider default user.
if [ -z "${2}" ];then
	SSH_USER="${DEFAULT_SSH_USER}"
else
	SSH_USER="${2}"
fi

### Determining IP
IP="${NID}.${LAST_OCT}"

### Attempting connections.
ssh -i ${PUB_KEY} -l ${SSH_USER} ${IP}
