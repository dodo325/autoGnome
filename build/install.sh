#!/bin/bash
#                   __           ____                                          
#                 /\ \__       /\  _`\                                        
#    __     __  __\ \ ,_\   ___\ \ \L\_\    ___     ___     ___ ___      __   
#  /'__`\  /\ \/\ \\ \ \/  / __`\ \ \L_L  /' _ `\  / __`\ /' __` __`\  /'__`\ 
# /\ \L\.\_\ \ \_\ \\ \ \_/\ \L\ \ \ \/, \/\ \/\ \/\ \L\ \/\ \/\ \/\ \/\  __/ 
# \ \__/.\_\\ \____/ \ \__\ \____/\ \____/\ \_\ \_\ \____/\ \_\ \_\ \_\ \____\
#  \/__/\/_/ \/___/   \/__/\/___/  \/___/  \/_/\/_/\/___/  \/_/\/_/\/_/\/____/

peints(){
  echo -e '\033[1;42m $1 \033[0m'
}

peints 'Install GIT'
sudo apt install git
CURRENT_DESKTOP=$(echo "$XDG_CURRENT_DESKTOP" | grep -Eoi 'xfce|kde|gnome')
CURRENT_DESKTOP=$(echo "$CURRENT_DESKTOP" | sed -e 's/\(.*\)/\L\1/')

echo "[GUI] Checking Desktop Environment"
if [ -z "$CURRENT_DESKTOP" ]
then
      echo "[fail] Not found GUI"
      exit
else
      echo "[OK] detect $CURRENT_DESKTOP"
fi
sudo add-apt-repository ppa:atareao/telegram
sudo apt-get update
sudo apt-get install telegram
peints 'Install audacity'
sudo add-apt-repository ppa:ubuntuhandbook1/audacity
sudo apt-get update
sudo apt-get install -y audacity
peints 'Install Docker'
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common python-pip
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
sudo add-apt-repository deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable
sudo apt-get update
sudo apt-get install docker-ce

peints 'Install Docker: add in systemctl'
sudo systemctl status --no-pager docker

peints 'Install Docker: add user in docker groupe'
sudo usermod -aG docker ${USER}
# su - ${USER}
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders
rm -f microsoft.gpg
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"
peints 'Install WineHQ'
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-get update
sudo apt-get install --install-recommends winehq-stable
rm -f Release.key
CONTREPO=https://repo.continuum.io/archive/
ANACONDAURL=$(wget -q -O - $CONTREPO index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)
wget -O anaconda.sh $CONTREPO$ANACONDAURL
chmod +x anaconda.sh
./anaconda.sh


sudo snap install discord --classic
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.7
sudo apt-get -y install python3-pip
sudo apt-get install google-chrome-stable