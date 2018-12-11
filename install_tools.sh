#!/bin/bash
peints(){
  echo -e '\033[1;42m $1 \033[0m'
}

peints 'Install GIT'
sudo apt install git

peints 'Install System Monitor: Stacer'
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install -y stacer

peints 'Install Vivaldi Browser'
wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"
sudo apt update && sudo apt install -y vivaldi-stable
rm -f linux_signing_key.pub

peints 'Install Remmina (RDP & VNC viwer)'
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt-get update
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-secret

peints 'Install VirtualBox'
sudo apt install -y virtualbox

peints 'Install vlc'
sudo apt install -y vlc 

peints 'Install WineHQ'
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-get update
sudo apt-get install --install-recommends winehq-stable
rm -f Release.key


peints 'Install krita'
#sudo add-apt-repository ppa:kritalime/ppa
#sudo apt-get update
sudo apt-get install -y krita krita-l10n


peints 'Install audacity'
sudo add-apt-repository ppa:ubuntuhandbook1/audacity
sudo apt-get update
sudo apt-get install -y audacity


peints 'Install gparted'
sudo apt-get install gparted

peints 'Install Synergy'
sudo apt-get install libcanberra-gtk-module sni-qt
sudo apt install synergy

peints 'Install qBittorrent'
sudo apt install qbittorrent
