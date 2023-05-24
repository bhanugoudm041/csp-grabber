#!/bin/bash

#Requirements: Need to install below tools for this script to work
#Install chromium with below command
#sudo apt install chromium
#Install npm and chrome-har-capturer package with below commands
#sudo apt install npm
#sudo npm install chrome-har-capturer -g

if [[ -z $1  ]]
then
        echo "Usage: csp-report.sh <url>"
else
        chromium 2 > /dev/null &
        kill $(ps -a|grep chromium|head -n 1|awk '{print $1}')
        sleep 2s
        chromium --remote-debugging-port=9222 --headless 2> /dev/null &
        sleep 2s
        chrome-har-capturer -g 12000 -o /tmp/temp.har $1 1> /dev/null
        kill $(ps -a|grep chromium|head -n 1|awk '{print $1}')
        cat /tmp/temp.har|grep blocked-uri|cut -d ',' -f 7
        rm -rf /tmp/temp.har
fi
