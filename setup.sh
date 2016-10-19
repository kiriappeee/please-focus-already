#!/bin/bash

mkdir -p /Users/Shared/.scripts/pleasefocusalready/hosts
touch ./hosts/hosts.default.custom
touch ./hosts/hosts.peak.custom
cp ./scripts/copyhosts.sh /Users/Shared/.scripts/pleasefocusalready/copyhosts.sh
cp ./hosts/* /Users/Shared/.scripts/pleasefocusalready/hosts/
printf "Heads up! I'm going to add the scheduled stuff using launchctl. This needs sudo and you might be prompted for the password :)\n"
sleep 1
sudo cp ./schedules/* ~/Library/LaunchAgents/
sudo launchctl remove com.pleasefocusalready.peak
sudo launchctl remove com.pleasefocusalready.offpeak
sudo launchctl load ~/Library/LaunchAgents/com.pleasefocusalready.peak.plist
sudo launchctl load ~/Library/LaunchAgents/com.pleasefocusalready.offpeak.plist

printf "\n\nWould you like to activate the focus zone now? (y/n)"
read answer

if [ $answer == "y" ]
then
  /Users/Shared/.scripts/pleasefocusalready/copyhosts.sh peak
fi 
