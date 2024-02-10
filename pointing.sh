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
#pointing domain ke cloudflare
apt install jq curl -y
clear

echo -e ""
echo -e "${BLUE}┌──────────────────────────────────────────┐${NC}"
echo -e "${BLUE}│        AUTO SCRIPT BY ALAWI VPN          │${NC}"
echo -e "${BLUE}│   SCRIPT POINTING DOMAIN KE CLOUDFLARE   │${NC}"
echo -e "${BLUE}└──────────────────────────────────────────┘${NC}"
echo -e ""
read -rp "Input subdomain: " -e sub
read -rp "Input ip vps: " -e ip

DOMAIN=alawistore.my.id
SUB_DOMAIN=${sub}.alawistore.my.id
CF_ID=vpsvpsku@gmail.com
CF_KEY=cb9b858e75a955df979cf4bff74839df1943d

set -euo pipefail
IP=${ip};

echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
clear

echo -e ""
echo -e "${BLUE}┌──────────────────────────────────────────┐${NC}"
echo -e "${BLUE}│   POINTING DOMAIN KE CLOUDFLARE SELESAI  │${NC}"
echo -e "${BLUE}└──────────────────────────────────────────┘${NC}"
echo -e ""
rm -rf pointing.sh
read -p "Tekan [ enter ] untuk reboot"
reboot

sleep 1
