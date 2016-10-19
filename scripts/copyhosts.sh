#!/bin/bash
cd /Users/Shared/.scripts/pleasefocusalready/hosts
sudo cp /etc/hosts hosts.original.bak
if [ "$1" == "peak" ]
then
  cat hosts.default>>hosts.temp
  cat hosts.default.custom>>hosts.temp
  cat hosts.peak>>hosts.temp
  cat hosts.peak.custom>>hosts.temp
else
  cat hosts.default>>hosts.temp
  cat hosts.default.custom>>hosts.temp
fi
sudo cp hosts.temp /etc/hosts
rm hosts.temp
