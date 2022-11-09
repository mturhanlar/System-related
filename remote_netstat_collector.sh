#!/bin/bash


for i in $(cat ip.txt);

do 
    if ping -c 1 $i &> /dev/null
    then
        echo "$i not reachable bypassing" 
    else 
        
        ssh -o StrictHostKeyChecking=accept-new -t parallels@$i 'exec netstat -tunape > /tmp/result_$(hostname).txt'  ; 
        scp parallels@$i:'/tmp/result*' . ; 
        ssh -o StrictHostKeyChecking=accept-new -t parallels@$i 'exec rm /tmp/result_$(hostname).txt' ; 

    fi
done
