#!/bin/bash
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'


#Instal pointing domain
function pointing(){
    clear
    print_install "Memasang Packet Ponting Domain ke Cloudflare..."
    wget https://raw.githubusercontent.com/AlawiStore24/repoindo/main/pointing.zip
    unzip pointing.zip
    chmod +x pointing/*
    mv pointing/* /usr/local/sbin
    rm -rf pointing.zip
}
