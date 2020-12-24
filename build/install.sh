#!/bin/bash
#                   __           ____                                          
#                 /\ \__       /\  _`\                                        
#    __     __  __\ \ ,_\   ___\ \ \L\_\    ___     ___     ___ ___      __   
#  /'__`\  /\ \/\ \\ \ \/  / __`\ \ \L_L  /' _ `\  / __`\ /' __` __`\  /'__`\ 
# /\ \L\.\_\ \ \_\ \\ \ \_/\ \L\ \ \ \/, \/\ \/\ \/\ \L\ \/\ \/\ \/\ \/\  __/ 
# \ \__/.\_\\ \____/ \ \__\ \____/\ \____/\ \_\ \_\ \____/\ \_\ \_\ \_\ \____\
#  \/__/\/_/ \/___/   \/__/\/___/  \/___/  \/_/\/_/\/___/  \/_/\/_/\/_/\/____/

function peints { echo -e "\033[1;42m $1 \033[0m"; }
function peints_err { echo -e "\033[7;105;31m $1 \033[0m"; }


sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' 
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add - 
sudo apt update && sudo apt install vivaldi-stable -y


CURRENT_DESKTOP=$(echo "$XDG_CURRENT_DESKTOP" | grep -Eoi 'xfce|kde|gnome|unity')
CURRENT_DESKTOP=$(echo "$CURRENT_DESKTOP" | sed -e 's/\(.*\)/\L\1/')
peints "[GUI] Checking Desktop Environment"
if [ -z "$CURRENT_DESKTOP" ]
then
      peints_err "[fail] Not found GUI"
      exit
else
      peints "[OK] detect $CURRENT_DESKTOP"
fi
peints 'Install VirtualBox'
sudo apt install -y virtualbox
sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo apt-get update
sudo apt-get install stacer -y
prints "[GNOME-Extensions] Check GNOME-shell"

gnome_version=$(gnome-shell --version)
if [[ $gnome_version == GNOME* ]] ;
then
    prints "[OK] GNOME-shell"
else
    peints_err "[fail] GNOME Shell not install"
    exit;
fi

prints "[GNOME-Extensions] Install gnome-shell-extension-installer"
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/

prints "[GNOME-Extensions] Install extensions!"
gnome-shell-extension-installer 18
gnome-shell-extension-installer 905
gnome-shell-extension-installer 1228
gnome-shell-extension-installer 800
gnome-shell-extension-installer 779
gnome-shell-extension-installer 1160

printf '\nRestart Gnome Shell'
killall -3 gnome-shell
peints 'Install Synergy'
sudo apt-get install libcanberra-gtk-module sni-qt -y
sudo apt install synergy -y

# sudo apt install qtcreator qtbase5-dev cmake make g++ xorg-dev libssl-dev libx11-dev libsodium-dev libgl1-mesa-glx libegl1-mesa libcurl4-openssl-dev libavahi-compat-libdnssd-dev qtdeclarative5-dev libqt5svg5-dev libsystemd-dev git build-essential
# git clone https://github.com/symless/synergy-core.git
# cd synergy*
# mkdir build
# cd build
# cmake ..
# make
# sudo make install
peints 'Install qBittorrent'
sudo apt install qbittorrent -y


sudo apt-get install -y zsh
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#TODO: проблема с exit!
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k


sudo apt-get install -y fonts-powerline
fc-cache -vf

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source ~/.zshrc

# yes | cp res/MyZSH.sh ~/.zshrc
peints 'Install audacity'
sudo add-apt-repository ppa:ubuntuhandbook1/audacity -y
sudo apt-get update
sudo apt-get install -y audacity

#!/bin/bash

prints "[NumixTheme] Check GNOME-shell"

gnome_version=$(gnome-shell --version)
if [[ $gnome_version == GNOME* ]] ;
then
    prints "[OK] GNOME-shell"
else
    peints_err "[fail] GNOME Shell not install"
    exit;
fi

sudo apt-get update;

printf '\nRemove useless applications...'
sudo apt autoremove gnome-sudoku gnome-mahjongg gnome-mines gnome-todo gnome-todo-common aisleriot -y

printf '\nInstall gnome-tweak-tool...'
sudo apt install chrome-gnome-shell gnome-shell-extensions gnome-tweak-tool -y

printf '\nInstall Numix Theme'
sudo apt install numix-gtk-theme numix-icon-theme -y

printf '\nSet Numix Theme'
gsettings set org.gnome.desktop.interface gtk-theme "Numix"
gsettings set org.gnome.desktop.wm.preferences theme "Numix"
gsettings set org.gnome.desktop.interface icon-theme 'Numix'

printf '\nSet Dark Theme'
echo '[Settings]' > ~/.config/gtk-3.0/settings.ini
echo 'gtk-application-prefer-dark-theme=1' >> ~/.config/gtk-3.0/settings.ini


sudo apt update
sudo apt install nodejs npm -y
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders
rm -f microsoft.gpg


code --install-extension visualstudioexptteam.vscodeintellicode
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"