#!/bin/bash

scan_initial() {
	echo "INITIAL scan $1"
	sudo nmap -sC -sV -O -oA $1/initial $1 $2
}

scan_full() {
	echo "FULL scan $1"
	sudo nmap -sC -sV -O -p- -oA $1/full $1 $2
}

scan_udp() {
	echo "UDP scan $1"
	sudo nmap -sU -sV -oA $1/udp $1 $2
}

if [ -n "$1" ]
then
	mkdir $1
	scan_initial $1
	scan_full $1
	scan_udp $1
else
	for ip in $(cat ip_list.txt);
	do
		mkdir $ip
		scan_initial $ip
	done
	for ip in $(cat ip_list.txt);
	do
		scan_full $ip
	done
	for ip in $(cat ip_list.txt);
	do
		scan_udp $ip
	done
fi
