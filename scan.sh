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
sleep 1
echo -e ${CP}"[+] Checking Internet Connectivity"
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
  echo "No Internet Connection"
  exit 1
  else
  echo "Internet is present"
  
fi
function cors_urls(){
clear
banner
echo -n -e ${BLUE}"\n[+]Enter target urls list (e.g https://target.com) : "
read urls
sleep 1
echo -e ${CNC}"\n[+] Searching For Cors Misconfiguration"
for i in $(cat $urls); do
     file=$(curl -s -m5 -I  "{$i}" -H "Origin: evil.com")  
    echo -n -e ${YELLOW}"URL: $i" >> output.txt
    echo "$file" >> output.txt
    if grep -q evil   <<<"$file"
  then
  echo  -e ${RED}"\nURL: $i  Vulnerable"${RED}
  cat output.txt | grep -e URL  -e  evil  -e access-control-allow-credentials: >> vulnerable_urls.txt
  rm output.txt
  else
  echo -n -e ${GREEN}"\nURL: $i  Not Vulnerable"
   rm output.txt
 fi

done

}
function cors_single(){
clear
banner
echo -e -n ${CP}"\n[+] Enter domain name (e.g https://target.com) : "
read domain
sleep 1
echo -e ${CNC}"\n[+] Searching For Cors Misconfiguration"
file=$(curl -s -m5 -I $domain -H "Origin: evil.com")
echo -n -e ${YELLOW}"\nURL: $i" >> output.txt
echo "$file" >> output.txt
if grep -q evil   <<<"$file"
  then
  echo -n -e ${RED}"URL: $domain  Vulnerable\n"
  cat output.txt | grep   -e  evil  -e access-control-allow-credentials:
  rm output.txt
  else
  echo -n -e ${GREEN}" URL: $domain  Not Vulnerable"
   rm output.txt
 fi
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
