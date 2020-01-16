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



sudo apt-get install -y zsh
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#TODO: проблема с exit!
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k


sudo apt-get install -y fonts-powerline
fc-cache -vf

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source ~/.zshrc

yes | cp res/MyZSH.sh ~/.zshrc