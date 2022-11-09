#!/bin/bash


for i in $(cat ip.txt);

do 
    if nc -w 1 $i 22 &> /dev/null
    then
        ssh -o StrictHostKeyChecking=accept-new -t parallels@$i 'exec netstat -tunape > /tmp/result_$(hostname).txt'  ; 
        scp parallels@$i:'/tmp/result*' . ; 
        ssh -o StrictHostKeyChecking=accept-new -t parallels@$i 'exec rm /tmp/result_$(hostname).txt' ; 
    else 
        echo "$i not reachable bypassing" 
    fi
done
