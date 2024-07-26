#!/bin/bash

red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
cyan="\e[36m"
endcolor="\e[0m" 

function privileges (){
if [[ $(id -u) -ne 0 ]]; then
    echo -e "$red[!] WARNING!!! \n[!] This script must run with root privileges. \n[+] Please restart the script under root. \n[*] Terminating script operations...$endcolor"
    exit 1
fi
}

function commence(){
echo -e "$yellow*******************************************************************************"
echo -e "*******************************************************************************"
echo -e "*******************COMMENCING INSTALLATION TOOL CHECKUP:***********************"
echo -e "*******************************************************************************$endcolor"
}

function installation1(){
if ! command -v figlet &> /dev/null
    then
    echo -e "$red[!] Figlet is not installed$endcolor"
    echo "$yellow[+] Installing figlet$endcolor"
    apt-get install figlet -y &> /dev/null
        if ! command -v figlet &> /dev/null
            then
            echo -e "$red[!] Failed to install figlet$endcolor"
            sleep 0.1
            else
            echo -e "$green[*] Figlet is installed$endcolor"
        fi
        sleep 0.1
    else
    echo -e "$green[*] Figlet is already installed$endcolor"
    sleep 0.1
fi
}

function installation2(){
if ! command -v geoiplookup &> /dev/null
    then
    echo -e "$red[!] Geoiplookup is not installed$endcolor"
    echo -e "$yellow[+] Installing geoiplookup$endcolor"
    apt-get install geoip-bin -y &> /dev/null
        if ! command -v geoiplookup &> /dev/null
            then
            echo -e "$red[!] Failed to install geoiplookup$endcolor"
            sleep 0.1
            else
            echo -e "$green[*] Geoiplookup is installed$endcolor"
            sleep 0.1
        fi
    else
    echo -e "$green[*] Geoiplookup is already installed$endcolor"
    sleep 0.1
fi
}

function installation3(){
if ! command -v tor &> /dev/null || ! command -v torsocks &> /dev/null
    then
    echo -e "$red[!] Tor or torsocks is not installed$endcolor"
    echo -e "$yellow[+] Installing Tor and torsocks$endcolor"
    apt-get update &> /dev/null
    apt-get install tor torsocks -y &> /dev/null
    if ! command -v tor &> /dev/null || ! command -v torsocks &> /dev/null
        then
        echo -e "$red[!] Failed to install Tor or torsocks$endcolor"
        sleep 0.1
        else
        echo -e "$green[*] Tor and torsocks are installed$endcolor"
        sleep 0.1 
    fi
    else
    echo -e "$green[*] Tor and torsocks are already installed$endcolor"
    sleep 0.1
fi
}

function installation4(){
if ! command -v sshpass &> /dev/null
    then
    echo -e "$red[!] Sshpass is not installed$endcolor"
    echo -e "$yellow[+] Installing sshpass$endcolor"
    apt-get install sshpass &> /dev/null
    if ! command -v sshpass &> /dev/null
        then
        echo -e "$red [!] Failed to install sshpass$endcolor"
        sleep 0.1
        else
        echo -e "$green[*] Sshpass is installed$endcolor"
        sleep 0.1
    fi
    else
    echo -e "$green[*] Sshpass is already installed$endcolor"
    sleep 0.1
fi
}

function installation5(){
if ! command -v nmap &> /dev/null
    then
    echo -e "$red[!] Nmap is not installed$endcolor"
    echo -e "$yellow[+] Installing nmap$endcolor"
    apt-get install nmap &> /dev/null
    if ! command -v nmap &>/dev/null
        then
        echo -e "$red[!] Failed to install nmap$endcolor"
        sleep 0.1
        else
        echo -e "$green[*] Nmap is installed$endcolor"
        sleep 0.1
    fi
    else
    echo -e "$green[*] Nmap is already installed$endcolor"
    sleep 0.1
fi
}

function test(){
if ! command -v figlet &>/dev/null || ! command -v geoiplookup &>/dev/null || ! command -v tor &>/dev/null || ! command -v torsocks &>/dev/null || ! command -v sshpass &>/dev/null || ! command -v nmap &>/dev/null 
    then
    echo -e "$red[!] One or more of the tools needed to run this script is not installed and failed to autoinstall$endcolor"
    echo -e "$cyan[+]$endcolor$blue Please make sure to manually install the following tools:$endcolor$yellow figlet, geoiplookup, tor, torsocks, sshpass, nmap$endcolor$blue before running the script$endcolor"
    sleep 3  
    echo -e "$red[*] Exiting..."
    sleep 0.3
    exit 1 
    else
    echo -e "$yellow*******************************************************************************"
    echo -e "***********EVERYTHING IS GOOD TO GO, PROCEEDING TO SCRIPT OPERATIONS:**********"
    echo -e "*******************************************************************************"
    echo -e "*******************************************************************************$endcolor"
    sleep 0.3
    printf $red
    figlet SpySeek
    printf $endcolor
    sleep 0.3
fi
}

function anonymous(){
echo -e "\n$cyan[*]$endcolor$yellow Activating Tor and testing anonymity status... $endcolor"
service tor start &> /dev/null
sleep 5  # Give Tor some time to establish circuits

anon_ip=$(torsocks curl -s https://api.ipify.org)
if [ ! -z "$anon_ip" ]; then
    country=$(geoiplookup $anon_ip | awk -F ": " '{print $2}')
    echo -e "$green[!] You are ANONYMOUS! \n$cyan[+]$endcolor$blue Displaying Tor exit node IP: $endcolor$green$anon_ip $endcolor\n$cyan[+]$endcolor$blue Displaying exit node country: $endcolor$green$country$endcolor"
else 
    echo -e "$red[!] You are NOT ANONYMOUS!$endcolor" ; sleep 0.1
    echo -e "$cyan[+]$endcolor$yellow Restarting anonymity test $endcolor" ; sleep 0.1
    anonymous
fi
}

function remote(){
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please enter the IP address of a remote server: $endcolor")" ipserv
if [[ $ipserv =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
    then echo -e "$green[!] IP address is valid$endcolor"
    else echo -e "$red[!] IP address is invalid! Please re-enter the address $endcolor" ;  sleep 0.1 ; remote
fi
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please enter a username of the remote server: $endcolor")" userserv
if [ ! -z $userserv ] 
    then echo -e "$green[!] Server username registered ($endcolor$blue$userserv$endcolor$green)$endcolor" ; sleep 0.1
    else echo -e "$red[!] Server username was not registered. Please re-enter server details $endcolor" ; sleep 0.1 ; remote
fi
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please enter the password of the remote server: $endcolor")" servpw
if [ ! -z $servpw ] 
    then echo -e "$green[!] Server password registered ($endcolor$blue$servpw$endcolor$green)$endcolor" ; sleep 0.1
    else echo -e "$red[!] Server password was not registered. Please re-enter server details $endcolor" ; sleep 0.1 ; remote
fi
}

function scn(){
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please enter a domain name or IP address of the scanning target: $endcolor")" scan
if [[ $scan =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]] || [ ! -z $scan 2>/dev/null ] 
    then echo -e "$green[!] Scan target is valid$endcolor"
    else echo -e "$red[!] Scan target is invalid! Please re-enter connection details and scan address $endcolor" ;  sleep 0.1 ; remote
fi
echo -e "\n$cyan[+]$endcolor$blue Logging scan operation into scanlog.txt$endcolor"
echo $(date) [*] Collecting info on $scan >> scanlog.txt
echo -e "$cyan[+]$endcolor$yellow Attempting connection to remote server through Tor...$endcolor"
uptime=$(sshpass -p $servpw ssh -o StrictHostKeyChecking=no $userserv@$ipserv "uptime" 2>/dev/null)
if [ -z "$uptime" ]
    then
    echo -e "$red[!] Connection unsuccessful. Please re-enter server details...$endcolor" ; sleep 0.1 ; remote
    else
    echo -e "$green[!] Connection successful $endcolor\n$cyan[+]$endcolor$blue Server uptime: $endcolor$green$uptime$endcolor"
fi
echo -e "$yellow*******************************************************************************"
echo -e "*************************COMMENCING SCANNING OPERATION*************************"
echo -e "*******************************************************************************$endcolor"

sshpass -p $servpw ssh -o StrictHostKeyChecking=no $userserv@$ipserv "whois $scan" >> $scan.txt
sshpass -p $servpw ssh -o StrictHostKeyChecking=no $userserv@$ipserv "nmap -Pn -p- -sV $scan" >> $scan.txt
}

function quit(){
echo -e "\n$cyan[*]$endcolor$yellow Whois scan was saved in $endcolor$green$scan.txt$endcolor \n$cyan[*]$endcolor$yellow Nmap port scan was saved in $endcolor$green$scan.txt $endcolor\n"
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to repeat the scan? [Y/N] $endcolor")" rescan
case $rescan in
Y) echo -e "$cyan[+]$endcolor$blue Rescanning...$endcolor"
sshpass -p $servpw ssh -o StrictHostKeyChecking=no $userserv@$ipserv "whois $scan" >> $scan.txt
sshpass -p $servpw ssh -o StrictHostKeyChecking=no $userserv@$ipserv "nmap -Pn -p- -sV $scan" >> $scan.txt
;;
N) read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to scan another target? [Y/N] $endcolor")" response
    case  $response in
    Y) sleep 0.3 ; scn
    ;;
    N)
    echo -e "\n$yellow*******************************************************************************"
    echo -e "*****************************SCAN COMPLETE! EXITING...*************************"
    echo -e "*******************************************************************************"
    echo -e "*******************************************************************************$endcolor"
    service tor stop &> /dev/null
    exit 1 
    ;;
    *)
    echo -e "$red[!] Invalid input!$endcolor" ; sleep 0.3
    echo -e "\n$yellow*******************************************************************************"
    echo -e "*****************************SCAN COMPLETE! EXITING...*************************"
    echo -e "*******************************************************************************"
    echo -e "*******************************************************************************$endcolor"
    service tor stop &> /dev/null
    exit 1
    ;;
    esac
;;
*) echo -e "$red[!] Invalid input! Please choose a correct input [Y/N] $endcolor" ; sleep 0.1 ; quit
;;
esac
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Would you like to scan another target? [Y/N] $endcolor")" answer
case  $answer in
Y) sleep 0.3 ; scn
;;
N)
echo -e "\n$yellow*******************************************************************************"
echo -e "*****************************SCAN COMPLETE! EXITING...*************************"
echo -e "*******************************************************************************"
echo -e "*******************************************************************************$endcolor"
service tor stop &> /dev/null
exit 1 
;;
*)
echo -e "$red[!] Invalid input!$endcolor" ; sleep 0.3
echo -e "\n$yellow*******************************************************************************"
echo -e "*****************************SCAN COMPLETE! EXITING...*************************"
echo -e "*******************************************************************************"
echo -e "*******************************************************************************$endcolor"
service tor stop &> /dev/null
exit 1
;;
esac
}

privileges
commence
installation1
installation2
installation3
installation4
installation5
test
anonymous
remote
scn
quit
