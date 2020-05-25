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


#wget https://www.arduino.cc/download_handler.php
prints "[info] Arduino installing...!"
sudo apt-get install gcc-avr avr-libc -y
sudo apt-get update && sudo apt-get install arduino arduino-core  -y
sudo usermod -aG dialout ${USER}

prints "[ok] Arduino installed!"


sudo snap install discord --classic
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
printf '\nInstall OBS Studio'
sudo apt-get install ffmpeg -y
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt-get update
sudo apt-get install obs-studio -y
sudo apt update
sudo apt install nodejs npm -y

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
peints 'Install WineHQ'
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-get update
sudo apt-get install --install-recommends winehq-stable
rm -f Release.key
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

sudo add-apt-repository ppa:oguzhaninan/stacer -y
sudo apt-get update
sudo apt-get install stacer -y
peints 'Install Nautilus Terminal 3' 
sudo add-apt-repository ppa:flozz/nautilus-terminal -y
sudo apt update
sudo apt install nautilus-terminal -y

nautilus -q
sudo apt install dconf-editor -y

peints 'Install krita'
#sudo add-apt-repository ppa:kritalime/ppa
#sudo apt-get update
sudo apt-get install -y krita krita-l10n
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


wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"
sudo apt update && sudo apt install -y vivaldi-stable
rm -f linux_signing_key.pub
peints 'Install audacity'
sudo add-apt-repository ppa:ubuntuhandbook1/audacity -y
sudo apt-get update
sudo apt-get install -y audacity

peints 'Install tmux'
sudo apt install -y tmux 
peints 'Install qBittorrent'
sudo apt install qbittorrent -y


wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -y -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update

sudo apt-get install google-chrome-stable -y

peints 'Install Docker'
curl -fsSL https://get.docker.com -o get-docker.sh; sh get-docker.sh; rm get-docker.sh

peints 'Install Docker: add in systemctl'
sudo systemctl enable docker
sudo systemctl status --no-pager docker

peints 'Install Docker: add user in docker groupe'
sudo usermod -aG docker ${USER}

peints 'Install Docker-compose: add user in docker groupe'

sudo apt-get install libffi-dev libssl-dev -y

sudo apt-get install -y python python-pip

sudo apt-get remove python-configparser -y

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders
rm -f microsoft.gpg


code --install-extension visualstudioexptteam.vscodeintellicode
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"
CONTREPO=https://repo.continuum.io/archive/
ANACONDAURL=$(wget -q -O - $CONTREPO index.html | grep "Anaconda3-" | grep "Linux" | grep "86_64" | head -n 1 | cut -d \" -f 2)
wget -O anaconda.sh $CONTREPO$ANACONDAURL
chmod +x anaconda.sh
./anaconda.sh

prints "[ok] Anaconda installed!"
rm anaconda.sh
