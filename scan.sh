#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'
function banner(){
echo -e ${CP}"               ____ ___  ____  ____   ____    _    _   _ _   _ _____ ____     "
echo -e ${CP}"              / ___/ _ \|  _ \/ ___| / ___|  / \  | \ | | \ | | ____|  _ \    "
echo -e ${CP}"              | |  | | | | |_) \___ \| |    / _ \ |  \| |  \| |  _| | |_) |  "
echo -e ${CP}"              | |__| |_| |  _ < ___) | |___/ ___ \| |\  | |\  | |___|  _ <   "
echo -e ${CP}"              \____\___/|_| \_\____/ \____/_/   \_\_| \_|_| \_|_____|_| \_\  "

echo -e "${BLUE2}                  A Framework for Scanning CORS MISCONFIGURATION"
echo -e "       ${BLUE2}                           Coded By: Machine404"
echo -e " ${RED}                             https://www.facebook.com/unknownclay "
}

d=$(date +"%b-%d-%y %H:%M")
function cors_urls(){
clear
banner
echo -n -e ${BLUE}"\n[+]Enter target url list (e.g https://target.com) : "
read urls
sleep 1
echo -e "\n\e[00;33m#################### CORS SCANNER Started On: $d ####################\e[00m"
for i in $(cat $urls); do
     file=$(curl -m5 -I  "{$i}" -H "Origin: evil.com")
    echo -n -e ${YELLOW}"VULNERABLE: $i" >> output.txt
    echo "$file" >> output.txt
    

done
sleep 1
echo -e "\n\e[00;37m##################Searching For CORS ###########################\e[00m"
sleep 1
cat output.txt  |  grep -e  VULNERABLE  -e  evil  -e access-control-allow-credentials: | tee vulnerable.txt
rm output.txt
}
function cors_single(){
clear
banner
echo -e -n ${ORANGE}"\n[+] Enter domain name (e.g https://target.com) : "
read domain
file=$(curl -m5 -I $domain -H "Origin: evil.com")
echo -n -e ${YELLOW}"VULNERABLE: $i" >> output.txt
echo "$file" >> output.txt
cat output.txt | grep -e  VULNERABLE  -e  evil  -e access-control-allow-credentials:
rm output.txt
}
menu(){
clear
banner
echo -e ${YELLOW}"\n[*] Which Type of Scan u want to Perform\n "
echo -e "  ${NC}[${CG}"1"${NC}]${CNC} Single domain Scan"
echo -e "  ${NC}[${CG}"2"${NC}]${CNC} List of domains"
echo -e "  ${NC}[${CG}"3"${NC}]${CNC} Exit"

echo -n -e ${YELLOW}"\n[+] Select: "
        read cors_play
                if [ $cors_play -eq 1 ]; then
                        cors_single
                elif [ $cors_play -eq 2 ]; then
                        cors_urls
                elif [ $cors_play -eq 3 ]; then
                      exit
                fi

}
menu
