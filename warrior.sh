#!/bin/bash
# Warrior.sh - An easy way to deploy ArchiveTeam Warrior instances quickly on fresh Debian installs using Docker
#
# Variables
nick=$1
proj=auto
instances=$2
threads-per-instance=$3
sudo apt-get update
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y docker-ce
for i in $(seq $2); do
	sudo docker run \
    	  --detach \
    	  --env DOWNLOADER="$nick" \
    	  --env CONCURRENT_ITEMS=$threads-per-instance \
    	  --env SELECTED_PROJECT="$proj" \
    	  --restart always \
    	  --name ATwarrior \
    	  archiveteam/warrior-dockerfile
done
echo "Done! $instances containers running ArchiveTeam Warrior are deployed!"
exit 0
