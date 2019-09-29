#!/bin/bash

working_macaddr="b8:ee:65:17:1f:d7";

if [[ $(id -u) -ne 0 ]]; then
	echo -e "\e[31m[ERROR] Script should be ran as root\e[0m";
	exit 1;
fi

if [[ $# -ne 4 ]]; then
	echo -e "\e[31m usage: sudo ./mac_changer.sh -i <interface> -m <mac_address_to_be_spoofed>\e[0m";
	exit 1;
fi


while getopts ":i:m:" opt; do
  case $opt in
    i) interface="$OPTARG"
    ;;
    m) mac_address="$OPTARG"
    ;;
    \?) echo -e "\e[31mInvalid option -$OPTARG\e[0m" >&2
    ;;
  esac
done

if hash ip 2>/dev/null; then
	ip link set $interface down;
	ip link set $interface address $mac_address;
	ip link set $interface up;
	echo -e "\e[32mMac address changed successfully\e[0m";
else
	echo -e "\e[31m[ERROR]ip command is not present on your system\e[0m";
fi









