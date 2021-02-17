#!/bin/bash
# A small snippet for automate change proxy variables


function change_proxy() {
    # change_proxy ip:port
    echo -e "Removing old proxy..."
    unset http_proxy
    unset https_proxy
 
    echo -e "Seting up $1 as new proxy..."
    export http_proxy=$1
    export https_proxy=$1
 
    echo -e "Testing.."
    rs=`curl www.ifconfig.me/ip`
    ip=`echo $1 | cut -d: -f1`
    echo $rs
    if [ $ip == $rs ]; then
        echo "OK!"
    else
        echo "Failed!"
    fi
}
 
function handler()  {
    # read_proxy_data FILE_NAME_TO_READ
    IFS=$'\n' read -d '' -r -a lines < $1
    LEN=${#lines[@]}
    echo $LEN
    echo ${lines[@]}
    while [ true ]; do
        index=$(($RANDOM % $LEN))
        change_proxy ${lines[$index]}
        sleep $2
    done
}
 
 
FILENAME="/home/h4niz/Downloads/proxy_data.txt"
TIMETODELAY=1
handler $FILENAME $TIMETODELAY